From: Jordi Prats <jprats@cesca.es>
Subject: snapshooting a fs
Date: Mon, 05 Mar 2007 09:43:02 +0100
Message-ID: <45EBD816.1000100@cesca.es>
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
I'm going to develop a module to create a snapshoot with LVM before =

mounting, destroying it after umounting.

I have thought tree different ways to do it:

- Do it as a module, defining a different fstype (like "ext3lvm"), using =

the generic module to mount and umount the real ext3 fs.

- Modify the generic module to add a option (like -lvmsnapshoot)

- Like Jim Carter proposed, create a module to allow mounting and =

umounting the fs to a script.

What do you think would be best?

Thank you,
Jordi

-- =

......................................................................
         __
        / /          Jordi Prats
  C E / S / C A      Dept. de Sistemes
      /_/            Centre de Supercomputaci=F3 de Catalunya

  Gran Capit=E0, 2-4 (Edifici Nexus) =B7 08034 Barcelona
  T. 93 205 6464 =B7 F.  93 205 6979 =B7 jprats@cesca.es
...................................................................... =
