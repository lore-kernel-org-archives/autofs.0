From: Stephen Constantinou <stephanos@writeme.com>
Subject: auto mounting floppies
Date: Sun, 10 Feb 2008 17:43:02 +0000
Message-ID: <47AF37A6.1010004@writeme.com>
Reply-To: stephanos@writeme.com
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
To: Auto FS Mailing List <autofs@linux.kernel.org>

Dear All

I received technical support from Mandriva up to the point where they 
suggest I read the manual.  I did and understood very little and was 
surprised that they would go no further.

It took several attempts to get over to them that although I can mount 
floppies manually at the command line as root and I can mount floppies 
using a "Link to Device" icon I made for the desktop I was trying to 
achieve in Mandriva 2008 what I had taken for granted in Mandriva 2007. 
  That is as follows:
   "In 2007 I can insert a floppy and navigate in
    konqueror to /media/floppy and click on the
    directory and then the floppy is mounted and
    the content of the floppy appears in konqueror."

The floppy instruction of /etc/fstab is as follows
"/dev/fd0 /media/floppy/ auto umask=0022,users,auto,exec,flush 0 0"

In Control Centre I checked the packages and found that
"autofs 5.0.2-8" was already installed.

So I read the tutorial that the Mandriva tech support man suggested:
I checked to make sure the kernel supported autofs
[root@localhost stephanos]# cat /proc/filesystems
...
nodev autofs
[root@localhost stephanos]#
It does

So I checked to see if it was loaded:
[root@localhost stephanos]# /sbin/lsmod
Module Size Used by
.....
autofs4 18788 0
.....
[root@localhost stephanos]#
It was

While I do feel a sense of achievement to have done so much I did not 
understand any more and could not progress.

Any further help appreciated

Stephen
