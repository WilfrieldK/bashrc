#!/bin/bash
#

function yubicrypt() {
    my_pubkey="\
-----BEGIN PUBLIC KEY-----\n\
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAv+9hU0faKxSGgR9fIe+j\n\
TeSz24VE4HFComVw+UMb1dsUXweOyvD+5q4xdZthTbudjSZ85nbI/9cdtOXa9Map\n\
laDdqQziJBQEQjx3OIQ/u2wAhHUeiXa8nU4XPVj7Jy3kc2U3TIQpfsYNWnIK56Jw\n\
CZVYDdyU5SC3Zf/01T5uRFpm+/zbH3uGKjZgC4IXO/YZkVdmmROUCeKn8NxlzL/i\n\
/15ZDTMCi1j2tM0XOI59U9tlJaPQhdtwyRyeAj6bvxXueIyjnb0tQkLE+5iveh5w\n\
I8DrUAeHd0zoWJvRlGroFbPurXd/tYs2gY1KOhOUIvkat+bw+5RRC48hjvpdWBHN\n\
gwIDAQAB\n\
-----END PUBLIC KEY-----"

    if [ ! "$(command -v openssl)" ]; then
        printf "openssl isnt installed, cannot crypt file\n"
        return 0
    fi
    if [ -z "${1}" ]; then
        printf "Please put the file to crypt as argument\n"
        return 0
    fi
    if [ ! -f "${1}" ]; then
        printf "This argument is not a file\n"
        return 0
    fi
    output_filename="${1}.yubi.crypt"
    if [ -f "${output_filename}" ]; then
        printf "Output file already exists. Abort !\n"
        return 0
    fi
    openssl rsautl -encrypt -inkey <(echo -e "${my_pubkey}") -in "${1}" -pubin -out "${output_filename}"
}

function yubidecrypt() {
    if [ ! "$(command -v pkcs11-tool)" ]; then
        printf "pkcs11-tool isnt installed, cannot decrypt file\n"
        return 0
    fi
    if [ -z "${1}" ]; then
        printf "Please put the file to decrypt as argument\n"
        return 0
    fi
    if [ ! -f "${1}" ]; then
        printf "This argument is not a file\n"
        return 0
    fi
    if [[ ${1} =~ \.yubi\.crypt$ ]]; then
        output_filename="$(echo "${1}" | awk -F'.yubi.crypt' '{print $1}')"
    else
        output_filename="${1}.yubi.decrypt"
    fi
    if [ -f "${output_filename}" ]; then
        printf "Output file already exists. Abort !\n"
        return 0
    fi
    pkcs11-tool --id 01 --decrypt -m RSA-PKCS --input-file "${1}" -o "${output_filename}"
}
