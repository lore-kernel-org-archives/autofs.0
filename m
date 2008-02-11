From: Ian Kent <raven@themaw.net>
Subject: Re: auto mounting floppies
Date: Mon, 11 Feb 2008 17:09:56 +0900
Message-ID: <1202717396.24318.6.camel@raven.themaw.net>
References: <47AF37A6.1010004@writeme.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <47AF37A6.1010004@writeme.com>
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
To: stephanos@writeme.com
Cc: Auto FS Mailing List <autofs@linux.kernel.org>


On Sun, 2008-02-10 at 17:43 +0000, Stephen Constantinou wrote:
> Dear All
> 
> I received technical support from Mandriva up to the point where they 
> suggest I read the manual.  I did and understood very little and was 
> surprised that they would go no further.
> 
> It took several attempts to get over to them that although I can mount 
> floppies manually at the command line as root and I can mount floppies 
> using a "Link to Device" icon I made for the desktop I was trying to 
> achieve in Mandriva 2008 what I had taken for granted in Mandriva 2007. 
>   That is as follows:
>    "In 2007 I can insert a floppy and navigate in
>     konqueror to /media/floppy and click on the
>     directory and then the floppy is mounted and
>     the content of the floppy appears in konqueror."

None of this has anything to do with autofs.

> 
> The floppy instruction of /etc/fstab is as follows
> "/dev/fd0 /media/floppy/ auto umask=0022,users,auto,exec,flush 0 0"

And neither does this.

> 
> In Control Centre I checked the packages and found that
> "autofs 5.0.2-8" was already installed.

Generally, autofs is not the best thing to use for automounting
removable media. Try investigating a possible problem with HAL.

Ian
