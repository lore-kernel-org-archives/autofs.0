From: Geoff Mishkin <gmishkin@acs.bu.edu>
Subject: embedded spaces in automounter map options field
Date: Tue, 17 Aug 2004 10:08:16 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200408171008.26436.gmishkin@acs.bu.edu>
Reply-To: gmishkin@bu.edu
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: Text/Plain; charset="us-ascii"
To: autofs@linux.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have a situation that requires me to have embedded spaces in the options 
field of my automounter map.  To make things trickier, the map has to be 
generated with an executable map.  I am using shfs and have to use it's cmd 
mount option to force it to connect using a specific private key file.  This 
requires there to be embedded spaces in the options field, like this:

- -fstype=shfs,cmd="ssh -i /usr/keys/<username> <username>@<host>"

Which causes the automounter to complain bitterly.  Most of the information 
I've found is for having spaces in share names or mount points, but the 
advice given doesn't work in the options field.  I've tried all kinds of 
quotes, backslashing, etc.  I'd greatly appriciate help.

Please CC me on replies as I am not subscribed to the list.

			--Geoff Mishkin <gmishkin@us.ibm.com>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBIhFXpH0X57UnVFoRAoChAJ9oQGxmeQse0iwBmmi6DlrSo6CziQCgyJ62
TiVrjLCwWxaFLvjs2wVZIKQ=
=aOwF
-----END PGP SIGNATURE-----
