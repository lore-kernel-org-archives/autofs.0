From: Dirk Heinrichs <ext-dirk.heinrichs@nokia.com>
Subject: Program maps - examples?
Date: Tue, 18 Nov 2003 13:55:48 +0100
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FBA16D4.9040806@nokia.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: autofs@linux.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I'm new to this list and have the following problem:

I wan't to automount home directories from a file server on a linux
machine. The problem is that the tree on the server is different from
the what it looks like when mounted:

Local: 	/level1/level2/home/username
Server: /prefix/homestore_[:a-z:]/username

This means when I want to mount my own home I have to mount
server:/prefix/homestore_d/dheinric to /level1/level2/home/dheinric. I
guess there's no other way than using a program map, but there's not
much documentation/examples about this in the package. Can someone sched
some light on this, please.

I've also looked onto our Solaris machines. They seem to cascade the
maps, which I guess is not possible on linux, right?

Thanx...

	Dirk
- --
Dirk Heinrichs          | Tel:  +49 (0)151 1513 6954
Configuration Manager   | Fax:  +49 (0)211 47068 111
Cap Gemini Ernst & Young| Mail: dirk.heinrichs@cgey.com
Hambornerstra=DFe 55      | Web:  http://www.cgey.com
D-40472 D=FCsseldorf      | ICQ#: 110037733
GPG Public Key C2E467BB | Keyserver: www.keyserver.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/uhbU8NVtnsLkZ7sRAqcVAJ0aLUABC1g9ibyOL5dxbLS1mGrqNQCgrDOX
ZKkbt4tCeAbd/ntsDpSIJao=3D
=3D3zV0
-----END PGP SIGNATURE-----
