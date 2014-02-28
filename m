From: Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: "Too many levels of symbolic links"
Date: Fri, 28 Feb 2014 21:35:25 +0100
Message-ID: <5310F30D.9040407@molgen.mpg.de>
References: <1391145206.2486.25.camel@perseus.fritz.box> <52EB7694.20707@molgen.mpg.de> <52EB7B07.2070707@molgen.mpg.de> <530484B7.6030305@molgen.mpg.de> <1392896501.2508.16.camel@perseus.fritz.box> <1392898704.2508.26.camel@perseus.fritz.box> <530625D0.7020808@molgen.mpg.de> <1392946952.2495.3.camel@perseus.fritz.box> <53076D91.7050703@molgen.mpg.de> <53107D4A.90904@molgen.mpg.de> <20140228132906.GM15017@sh-el6.eng.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms060500050902020704000207"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <20140228132906.GM15017@sh-el6.eng.rdu2.redhat.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Alexander Viro <aviro@redhat.com>
Cc: Ian Kent <raven@themaw.net>, autofs <autofs@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms060500050902020704000207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Am 28.02.2014 14:29, schrieb Alexander Viro:
> On Fri, Feb 28, 2014 at 01:12:58PM +0100, Donald Buczek wrote:
>
>> Obviously, "cleared mounted on dentry" is missing.
>>
>> It looks like we enter put_mountpoint() but don't get to
>> dentry->d_flags &=3D ~DCACHE_MOUNTED;
>>
>> mp->m_count is not zero probably.
>>
>> What does it mean? The mount is still locked but not in the mount hash=
?
> No, it means that something else is mounted on the same dentry (in anot=
her
> part of mount tree, obviously).
>
> If you mount the same fs on two different mountpoints, e.g.
> mount /dev/sda1 /mnt
> mount /dev/sda1 /tmp/foo
> you will have the same dentries seen in two places.  Now,
> mount /dev/sdb11 /mnt/a
> mount /dev/sdc5 /tmp/foo/a
>
> and you've got two different filesystems mounted on two different place=
s
> (/mnt/a and /tmp/foo/a).  These two places have different vfsmounts,
> but the same dentry.  struct mountpoint is associated with dentry, so
> it's also the same for both.  And it serves as a mountpoint for two
> vfsmounts - one for fs from sdb11, another for fs from sdc5.
>
> Now umount /mnt/a; one of those two vfsmounts is gone now.  struct moun=
tpoint
> survives, of course, and dentry is *still* a mountpoint.  sdc5 is still=

> mounted on /tmp/foo/a, after all...

Thanks. So I guess, the idea of "struct mountpoint" is to make the=20
dentries smaller by not having the mount count embedded in each one,=20
99.9%  not needing it?

OMG, I've just found this in the log:

> 91286 2014-02-26T14:09:56.830515+01:00 kasslerbraten kernel:=20
> [195977.007799] pid 8644: d_set_mounted: dentry=3Dffff88004690c710 root=

> 91287 2014-02-26T14:09:56.830527+01:00 kasslerbraten kernel:=20
> [195977.007802] pid 8644: d_set_mounted: set mounted on=20
> dentry=3Dffff88004690c710 root
> 91288 2014-02-26T14:09:56.830529+01:00 kasslerbraten kernel:=20
> [195977.007873] pid 8644: put_mountpoint: mp=3Dffff8800b8aa1a38
> 91289 2014-02-26T14:09:56.830530+01:00 kasslerbraten kernel:=20
> [195977.007877] pid 8644: d_set_mounted: dentry=3Dffff8800ca45e810 tmp
> 91290 2014-02-26T14:09:56.830535+01:00 kasslerbraten kernel:=20
> [195977.007878] pid 8644: d_set_mounted: set mounted on=20
> dentry=3Dffff8800ca45e810 tmp
> 91291 2014-02-26T14:09:56.830536+01:00 kasslerbraten kernel:=20
> [195977.007881] pid 8644: put_mountpoint: mp=3Dffff8800b8aa1a38
> 91292 2014-02-26T14:09:56.830537+01:00 kasslerbraten kernel:=20
> [195977.007900] pid 8644: d_set_mounted: dentry=3Dffff880046960450=20
> old-root-mjn70Q
> 91293 2014-02-26T14:09:56.830538+01:00 kasslerbraten kernel:=20
> [195977.007901] pid 8644: d_set_mounted: set mounted on=20
> dentry=3Dffff880046960450 old-root-mjn70Q
> 91294 2014-02-26T14:09:56.830539+01:00 kasslerbraten kernel:=20
> [195977.007903] pid 8644: put_mountpoint: mp=3Dffff8800a5f1dbd0
> 91295 2014-02-26T14:09:56.830540+01:00 kasslerbraten kernel:=20
> [195977.007904] pid 8644: put_mountpoint: cleared mounted on=20
> dentry=3Dffff88004690c710 root
> 91296 2014-02-26T14:09:56.830541+01:00 kasslerbraten kernel:=20
> [195977.007905] pid 8644: put_mountpoint: mp=3Dffff8800a5f1da90
> 91297 2014-02-26T14:09:56.830541+01:00 kasslerbraten kernel:=20
> [195977.007954] pid 8644: put_mountpoint: mp=3D0000014f00490049
> 91298 2014-02-26T14:09:56.830542+01:00 kasslerbraten kernel:=20
> [195977.007955] pid 8644: put_mountpoint: mp=3D0000000000000006
> 91299 2014-02-26T14:09:56.830543+01:00 kasslerbraten kernel:=20
> [195977.007961] pid 8644: put_mountpoint: mp=3Dffff8800a5f1dbd0
> 91300 2014-02-26T14:09:56.830544+01:00 kasslerbraten kernel:=20
> [195977.007963] pid 8644: put_mountpoint: mp=3Dffff8800a6023d10
> 91301 2014-02-26T14:09:56.830544+01:00 kasslerbraten kernel:=20
> [195977.007963] pid 8644: put_mountpoint: mp=3Dffff8800a6023d10
> 91302 2014-02-26T14:09:56.830545+01:00 kasslerbraten kernel:=20
> [195977.007964] pid 8644: put_mountpoint: mp=3Dffff8800a5f1dbd0

What is this? Where does "root" and "old-root-" come from? Why does 8644 =

survive dereferencing mp=3D0000000000000006 from the kernel? Is this stil=
l=20
related to autofs?

D.

--=20
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433



--------------ms060500050902020704000207
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
AQcBMBwGCSqGSIb3DQEJBTEPFw0xNDAyMjgyMDM1MjVaMCMGCSqGSIb3DQEJBDEWBBRNkbjc
GOJMvMp9TCgw2EzIyPlDVDBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsO
AwIHMA0GCCqGSIb3DQMCAgEoMHgGCSsGAQQBgjcQBDFrMGkwXjELMAkGA1UEBhMCREUxIDAe
BgNVBAoTF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MQ8wDQYDVQQDEwZNUEcgQ0ExHDAaBgkq
hkiG9w0BCQEWDW1wZy1jYUBtcGcuZGUCBxOjrz5v/mgwegYLKoZIhvcNAQkQAgsxa6BpMF4x
CzAJBgNVBAYTAkRFMSAwHgYDVQQKExdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDEPMA0GA1UE
AxMGTVBHIENBMRwwGgYJKoZIhvcNAQkBFg1tcGctY2FAbXBnLmRlAgcTo68+b/5oMA0GCSqG
SIb3DQEBAQUABIIBAKzMGTGKosWkoHGI8Cr1sgyXByQ9oHyG3WGzGRu3p53/Ih21GLWNOa0O
rLIu1xg0PNZ1ZLGApeBWQ8PIbLOCvYVvpYGZcAhDW24L00iEpPzGmK/RMHMX3BzQKw0jyx1/
ZNz+Ft66y9PY4drOaV/0to/3/1UPYRMxNuXoaIzhkw+RN6rDAGOsI8nIqTzMyYueyxykp6zw
RvmJX3WjsYjn8mChqQaX/Ced7odZIMflFGMmXKxCIJ/8rnh/ie23f53o8fsgb/3sDtx0MH5i
+BulZZdb7sazF0WjCdnlBaJk0S2BQ03cElO41v+4uGZ7VsbePdLHDCQt5GyQ4w+KqMFpgNUA
AAAAAAA=
--------------ms060500050902020704000207--
