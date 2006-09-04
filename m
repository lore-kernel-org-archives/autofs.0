From: Farkas Levente <lfarkas@bppiac.hu>
Subject: run a script at umount
Date: Mon, 04 Sep 2006 11:41:56 +0200
Message-ID: <44FBF4E4.6000609@bppiac.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

hi,
i use a few encrypted files as container for my encrypted data and use
few encrypted fs too (LUKS and truecrypt). currently there is no way to
simple use these file systems since (u)mount do not support these. i
wrote small scripts to use them. but it'd much easier if i can use
automount to mount these fs when i try to access them. eg. create a map
file which contains which fs should have to mount to which mount point
with which keyfile (usually i use key file form my pendrive). this can
be work, but the problem is umount. since auto map file contain only a
crypt which should have to called during mount, but no way (script) for
umount and all of these case is more than one umount (losetup,
cryptsetup, treycrypt etc call).
is there any way to do this with automount?
thanks in advance.
yours.

-- 
  Levente                               "Si vis pacem para bellum!"
