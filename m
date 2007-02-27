From: Jordi Prats <jprats@cesca.es>
Subject: module development
Date: Tue, 27 Feb 2007 23:09:58 +0100
Message-ID: <45E4AC36.3060707@cesca.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
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
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Hi all,
I'm new to this list. I need to develop a module for autofs for a custom
fs type, but I'm not really familiar with autofs. I'm supposing to do
this I need to do a module like modules/mount_generic.c but with my
custom stuff. For the mounting process it's all right, but to umount the
fs I also need to do some operations.

There isn't any hook to do my custom operations before or after (in my
cas doesn't matter) umounting it?

I'm sorry if this a simple or trivial question, but I didn't found how
to do this as a module.

Thank you all,
Jordi

-- =

......................................................................
        __
       / /          Jordi Prats Catal=E0
 C E / S / C A      Departament de Sistemes
     /_/            Centre de Supercomputaci=F3 de Catalunya

 Gran Capit=E0, 2-4 (Edifici Nexus) =B7 08034 Barcelona
 T. 93 205 6464 =B7 F.  93 205 6979 =B7 jprats@cesca.es
......................................................................
pgp:0x5D0D1321
......................................................................
