From: Martin Fick <fick@fgm.com>
Subject: Automounting on /. deleting entire FS!
Date: Mon, 11 Oct 2004 11:29:38 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20041011152938.GL21585@lego.fgm.com>
Mime-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org
Cc: Martin Fick <fick@lego.fgm.com>

Yup,

  The #$@!! sys admin of my home machine, (that's me,)
decided to fool the automounter into using '/' to mount his
partiions on and lost his entire filesystem.  Pouff,
everything that was not a mounted partition gone!!!  Now I
realize that I shouldn' have been deceitfull to the poor
little autofs daemon, I told hime to use '/.' since he
balked at '/', but did I really deserve this?

So a few questions:

   1) Why does the automounter delete files (or entire filesystems)? 

   2) How can one go about automounting a cdrom on /cdrom?

   3) Should this be fixed? i.e. if it's bad to use slash, then
      should any other path that works out to be slash be checked
      also? :)

   4) Are my files really gone?  Is there anything I can do to
      recover? (it is an ext3 fs, not ext2)     


  Still weeping/laughing,
  
  -Martin
