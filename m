From: Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: autofs linux 3.8.13 and "Too many levels of symbolic links"
Date: Sat, 01 Feb 2014 14:01:09 +0100
Message-ID: <52ECF015.9030707@molgen.mpg.de>
References: <52E92627.9050801@molgen.mpg.de> <1391223436.2501.39.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms000001050700070308050203"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1391223436.2501.39.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: autofs <autofs@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms000001050700070308050203
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Am 01.02.2014 03:57, schrieb Ian Kent:
> On Wed, 2014-01-29 at 17:02 +0100, Donald Buczek wrote:
>> Hello,
>>
>> we are trying to switch from amd to autofs. After successfully testing=

> I didn't notice this before, so as an aside from our discussion
>
> You were (perhaps are) an amd user.
>
> As it happens I'm working on adding an amd map parser to autofs,
> probably for similar reasons to you needing to switch away from using
> it. I guess it won't make much difference to you since many people use
> amd for its cross platform abilities. And, well, there's that bug we're=

> discussing ....
>
> But, fyi, let me tell you where it's at.
>
> I'm not sure how much of the functionality will end up in autofs quite
> yet but so far the things that likely won't be available are:
>
> - type program mounts
>    - needed in autofs too.
>    - but can't be done without significant autofs infrastructure
>      change (or they would have been done in autofs ages ago).
>    - would like to add this, probably some time later.
>
> - type nfsx mounts
>    - might (but probably not) get done for the initial commit.
>    - a bit hard to do within autofs.
>
> - type lustre mounts
>    - would like to do for initial commit but ....
>
> - type direct mounts
>    - I think I understand how these are supposed to work.
>    - don't work in amd on linux so can't check.
>    - can't find any references to users of them either.
>    - a bit difficult to do in autofs.
>    - undecided as yet, at best will do some time later.
>
> - map type passwd
>    - seems to prescriptive to be useful.
>    - unlikely to be implemented.
>
> - map type ndbm
>    - may implement later if people use it.
>    - would need to add to autofs as well for sane implementation.
>
> - configuration options not yet implemented
>    - fully_qualified_hosts
>    - unmount_on_exit
>    - browsable_dirs
>    - probably a couple of others I've missed.
>    - many of the configuration options aren't used or aren't
>      sensible within autofs.
>
> - man page for amd options
>    - autofs(5) will need to be updated before initial commit.
>
>
> I've probably missed a few things but this will give you an idea.
> My plan is to commit initial changes, announce this to try and get some=

> testers and continue to work on it after that. Eventually the amd map
> changes will be autofs-5.1.0.
>
> Any interest in this?
> Ian
>

Well, to be true, we don't need anything of this. Where we have used=20
some of the more complex map features of amd, I consider this a mistake=20
and I'm happy to find  another solution for that. As small and simple as =

possible is what we would appreciate the most.

Even with the current autofs code, much of the complexity comes from=20
features, we don't need (though I surly acknowledge that other do):=20
direct maps, nested mountpoints, ldap maps, nis maps... We could even=20
live without multithreading in the daemon. We could live without=20
automatic selection between nfs and local bind mounts (because we build=20
the maps on each node individually after we pushed around the=20
configuration data). We could live without expiration support in kernel=20
and daemon and just try to /bin/umount from our own scripts ourselves.=20
I'm not to happy with uid/gid of the original mount persisting in kernel =

data structure, perhaps to see the daemon die on getpwuid() in two=20
years, because the original account expired some month ago. For what?=20
For /${uid}/ in the paths? Our goal is to provide a stable, global=20
namespace to our nodes and not a "depends on who asked for it" namespace =

:-)

In our current setting, amd sits as a local nfs-server on the automount=20
directories, so any path resolution of an already mounted subdirectory=20
still goes through RPC serialisation and context switches and a big,=20
buggy user-mode daemon. This is the great performance and stability=20
problem we want to get rid of, so we go for in-kernel autofs. I think,=20
in the latest versions of amd they are working on supporting autofs too, =

but we had too many bad experience, we don't want to upgrade amd away=20
from our more or less stable version. So, please, autofs/automount,=20
don't become a second amd, stay as small and simple and fast and bugfree =

as possible. Just my view.

Regards
   Donald

--=20
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433



--------------ms000001050700070308050203
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIOKjCC
BCEwggMJoAMCAQICAgDHMA0GCSqGSIb3DQEBBQUAMHExCzAJBgNVBAYTAkRFMRwwGgYDVQQK
ExNEZXV0c2NoZSBUZWxla29tIEFHMR8wHQYDVQQLExZULVRlbGVTZWMgVHJ1c3QgQ2VudGVy
MSMwIQYDVQQDExpEZXV0c2NoZSBUZWxla29tIFJvb3QgQ0EgMjAeFw0wNjEyMTkxMDI5MDBa
Fw0xOTA2MzAyMzU5MDBaMFoxCzAJBgNVBAYTAkRFMRMwEQYDVQQKEwpERk4tVmVyZWluMRAw
DgYDVQQLEwdERk4tUEtJMSQwIgYDVQQDExtERk4tVmVyZWluIFBDQSBHbG9iYWwgLSBHMDEw
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDpm8NnhfkNrvWNVMOWUDU9YuluTO2U
1wBblSJ01CDrNI/W7MAxBAuZgeKmFNJSoCgjhIt0iQReW+DieMF4yxbLKDU5ey2QRdDtoAB6
fL9KDhsAw4bpXCsxEXsM84IkQ4wcOItqaACa7txPeKvSxhObdq3u3ibo7wGvdA/BCaL2a869
080UME/15eOkyGKbghoDJzANAmVgTe3RCSMqljVYJ9N2xnG2kB3E7f81hn1vM7PbD8URwoqD
oZRdQWvY0hD1TP3KUazZve+Sg7va64sWVlZDz+HVEz2mHycwzUlU28kTNJpxdcVs6qcLmPkh
nSevPqM5OUhqjK3JmfvDEvK9AgMBAAGjgdkwgdYwcAYDVR0fBGkwZzBloGOgYYZfaHR0cDov
L3BraS50ZWxlc2VjLmRlL2NnaS1iaW4vc2VydmljZS9hZl9Eb3dubG9hZEFSTC5jcmw/LWNy
bF9mb3JtYXQ9WF81MDkmLWlzc3Vlcj1EVF9ST09UX0NBXzIwHQYDVR0OBBYEFEm3xs/oPR9/
6kR7Eyn38QpwPt5kMB8GA1UdIwQYMBaAFDHDeRu69VPXF+CJei0XbAqzK50zMA4GA1UdDwEB
/wQEAwIBBjASBgNVHRMBAf8ECDAGAQH/AgECMA0GCSqGSIb3DQEBBQUAA4IBAQA74Vp3wEgX
3KkY7IGvWonwvSiSpspZGBJw7Cjy565/lizn8l0ZMfYTK3S9vYCyufdnyTmieTvhERHua3iR
M347XyYndVNljjNj7s9zw7CSI0khUHUjoR8Y4pSFPT8z6XcgjaK95qGFKUD2P3MyWA0Ja6ba
hWzAP7uNZmRWJE6uDT8yNQFb6YyC2XJZT7GGhfF0hVblw/hc843uR7NTBXDn5U2KaYMo4RMJ
hp5eyOpYHgwf+aTUWgRo/Sg+iwK2WLX2oSw3VwBnqyNojWOl75lrXP1LVvarQIc01BGSbOyH
xQoLBzNytG8MHVQs2FHHzL8w00Ny8TK/jM5JY6gA9/IcMIIE5zCCA8+gAwIBAgIECs6x2DAN
BgkqhkiG9w0BAQUFADBaMQswCQYDVQQGEwJERTETMBEGA1UEChMKREZOLVZlcmVpbjEQMA4G
A1UECxMHREZOLVBLSTEkMCIGA1UEAxMbREZOLVZlcmVpbiBQQ0EgR2xvYmFsIC0gRzAxMB4X
DTA3MDczMTEzMDgyNVoXDTE5MDYzMDAwMDAwMFowXjELMAkGA1UEBhMCREUxIDAeBgNVBAoT
F01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MQ8wDQYDVQQDEwZNUEcgQ0ExHDAaBgkqhkiG9w0B
CQEWDW1wZy1jYUBtcGcuZGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDYUXKe
oNTLgkGwbani4rlua5jzlzISfHnaj/5qS+mojQqA/eYa0bGucylV5hyQuyJz7d4gRckdhMDV
8DZIxERUIsFlXFj6HGHjaZjlhIHbo4S12GjLhTH5YZ37O7MHVw0L/JhhzUIxESM1ZfRT/xLq
hz2idJYjT98W9OFvzPgT0yrdieMzkLUz5X/fpY8MuyYBgxnddBJRw6ZtlhdCml4F8Q35pSb8
J2qANiwuJVu3WCTgL/ydo3eA8vDieMMZ7O+L1wAnCzBbHAjJ5H6xU1B7mlwmu7V3pToKPgcW
mlO0HcTpa68McNTGGiY8pO0/Rn1fXkqDYf8z0lPdWUWxbM1RAgMBAAGjggGvMIIBqzASBgNV
HRMBAf8ECDAGAQH/AgEBMAsGA1UdDwQEAwIBBjAdBgNVHQ4EFgQUAtYebgmrv1hlpwo8SDNh
0c59w1swHwYDVR0jBBgwFoAUSbfGz+g9H3/qRHsTKffxCnA+3mQwGAYDVR0RBBEwD4ENbXBn
LWNhQG1wZy5kZTCBiAYDVR0fBIGAMH4wPaA7oDmGN2h0dHA6Ly9jZHAxLnBjYS5kZm4uZGUv
Z2xvYmFsLXJvb3QtY2EvcHViL2NybC9jYWNybC5jcmwwPaA7oDmGN2h0dHA6Ly9jZHAyLnBj
YS5kZm4uZGUvZ2xvYmFsLXJvb3QtY2EvcHViL2NybC9jYWNybC5jcmwwgaIGCCsGAQUFBwEB
BIGVMIGSMEcGCCsGAQUFBzAChjtodHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290
LWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBHBggrBgEFBQcwAoY7aHR0cDovL2NkcDIucGNh
LmRmbi5kZS9nbG9iYWwtcm9vdC1jYS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcN
AQEFBQADggEBABtJz5i/SGqQOficdRUN6myFVmVelCYgkGT+zX7frnBRJFoVVafXolstZdVB
7ZpH9FAcqj8O6FTZyhAANwh3+Y1D6xYBWTB7mQGy0lUoUL+j0msZjaMvyj/2LCQp7cKB5vA4
h6Ntq5BN5MPcaRhunzjJey/i+J/3jMdG7KpufV47Gl0E8ky9lDegaM7SToG4IOQKwv1wsnuH
oxoGLRewxO7FmYd9uq9f4L2mHtqgq+vibT1DeehT0HGPnrjjd8NK6g2TvZwirwjydbGs7szB
5oxDm/pfWoJxYzO68HKTiVBlmaWMLpGw4/UsLE+5xJHpvNXfkYCQ3T+k99KBUZuIpKwwggUW
MIID/qADAgECAgcTo68+b/5oMA0GCSqGSIb3DQEBBQUAMF4xCzAJBgNVBAYTAkRFMSAwHgYD
VQQKExdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDEPMA0GA1UEAxMGTVBHIENBMRwwGgYJKoZI
hvcNAQkBFg1tcGctY2FAbXBnLmRlMB4XDTEyMDQxMDEzMTIxNFoXDTE1MDQxMDEzMTIxNFow
gYoxCzAJBgNVBAYTAkRFMSAwHgYDVQQKExdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDE0MDIG
A1UECxMrTWF4LVBsYW5jay1JbnN0aXR1dCBmdWVyIG1vbGVrdWxhcmUgR2VuZXRpazELMAkG
A1UECxMCSVQxFjAUBgNVBAMTDURvbmFsZCBCdWN6ZWswggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQC8AkX5++7fOB5qItwhRS7gQ6VJthfPItK8AMTlGeyuqHztDM4us3VKll9t
Z7HybeXypqTt38JNrU56RnIqRwk+ajvNngk0Z+72eLUXH+TydvemBJ4fvnkIYtOgO7PZfKTy
iDSCo2tt/PuqnMlacXhCOWrgljhYhZgaPeecoDC+7EA3S3IKVJNBPxT1VtwRb3M691Igu2Th
yar3F7BkeyimbJ8UKHLpeHX1UvUwfdO0Geem7tkC5JPHlhwMb0Lpr6VImyl6a1CW88yGP5s2
sp1Bnr31ZLISjwq3VCRggzjPcjZPo1bMXzg2yAsh3BUp3ljYYTxJHe2u/LGzsJoVB1crAgMB
AAGjggGqMIIBpjAJBgNVHRMEAjAAMAsGA1UdDwQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwHQYDVR0OBBYEFEUP5hp3anavBSte9vwsqlJ/LpMSMB8GA1UdIwQYMBaA
FALWHm4Jq79YZacKPEgzYdHOfcNbMB8GA1UdEQQYMBaBFGJ1Y3pla0Btb2xnZW4ubXBnLmRl
MHcGA1UdHwRwMG4wNaAzoDGGL2h0dHA6Ly9jZHAxLnBjYS5kZm4uZGUvbXBnLWNhL3B1Yi9j
cmwvY2FjcmwuY3JsMDWgM6Axhi9odHRwOi8vY2RwMi5wY2EuZGZuLmRlL21wZy1jYS9wdWIv
Y3JsL2NhY3JsLmNybDCBkgYIKwYBBQUHAQEEgYUwgYIwPwYIKwYBBQUHMAKGM2h0dHA6Ly9j
ZHAxLnBjYS5kZm4uZGUvbXBnLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDA/BggrBgEFBQcw
AoYzaHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctY2EvcHViL2NhY2VydC9jYWNlcnQuY3J0
MA0GCSqGSIb3DQEBBQUAA4IBAQAn66b/WvVhpEsNXTGaZhxnUbN4+unYyQ930uxLwYrvGVxz
oEb/DoB/HJnxwly4ZVPhJ+Md8JabjkUPU7uUV/DBKjpatREOzLESa1wE++lP1QytuhEU9eIn
LDQLzpXrB2JPR9eMhh/8Qez6ikCYgIP0vNPdX2wTc1FwLvrN2YIyGqmLgGBdbUEwqY1dFn8I
9LOZR0tZT+ynNfPoQv4W7ec4BtqAbvC6bEbJ9bu2ZNEOoeX4FzpCgvtKdwQQJVDbZ9U8F3BY
5rTzZnfc73PkcSN+oDTYUQi6tVhbIqEp+DIRwx3VynbXYzJUbyKB5I2TEi2896KnWEdkdiYD
SE8yrLDmMYIDVTCCA1ECAQEwaTBeMQswCQYDVQQGEwJERTEgMB4GA1UEChMXTWF4LVBsYW5j
ay1HZXNlbGxzY2hhZnQxDzANBgNVBAMTBk1QRyBDQTEcMBoGCSqGSIb3DQEJARYNbXBnLWNh
QG1wZy5kZQIHE6OvPm/+aDAJBgUrDgMCGgUAoIIBwTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0xNDAyMDExMzAxMDlaMCMGCSqGSIb3DQEJBDEWBBQFvzlL
FaOKoSAD23wfm8TCegAYdzBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsO
AwIHMA0GCCqGSIb3DQMCAgEoMHgGCSsGAQQBgjcQBDFrMGkwXjELMAkGA1UEBhMCREUxIDAe
BgNVBAoTF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MQ8wDQYDVQQDEwZNUEcgQ0ExHDAaBgkq
hkiG9w0BCQEWDW1wZy1jYUBtcGcuZGUCBxOjrz5v/mgwegYLKoZIhvcNAQkQAgsxa6BpMF4x
CzAJBgNVBAYTAkRFMSAwHgYDVQQKExdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDEPMA0GA1UE
AxMGTVBHIENBMRwwGgYJKoZIhvcNAQkBFg1tcGctY2FAbXBnLmRlAgcTo68+b/5oMA0GCSqG
SIb3DQEBAQUABIIBABUG97W9X42cxGlJRrmRO7nAAdcM9uEegESZY/gvJd293w5mEkR0Mj5D
5a0MbXBCo/kRbGJeTyMygE4zDQccHQB3drhPSbNeXb6B9suHkIAlDwCuqgzH3hZcTF7ZeI7l
9wmkso0bpntry1n34SQNtQgw9OastCujcGKB7nxOJSKyr6Cf4FjP/gaxr5Ic6zaW6DxXTJob
bIjoqhr2RgUFhqwD6ZhIcALLXE8ZTSFZ49rgevrrbtnzVZ5Dgsa5CEIKnEAkJMXgUoyZLsLN
S5t8f46ChQDJgd27k+YwIbVt2O7yN+wQlfydAq0d9KIMWx7Fh4uUbmUBezCB+lM5rSq6Od4A
AAAAAAA=
--------------ms000001050700070308050203--
