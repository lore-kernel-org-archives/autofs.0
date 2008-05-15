From: "Eric A. Bonney" <mailinglists@vanhlebarsoftware.com>
Subject: Re: Help mounting something other than /home
Date: Thu, 15 May 2008 15:56:48 -0400
Message-ID: <20080515155648.q29ovbfbi8kc8cwo@www.vanhlebarsoftware.com>
References: <20080515135124.ya89z47v0g4sco4w@www.vanhlebarsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080515135124.ya89z47v0g4sco4w@www.vanhlebarsoftware.com>
Content-Disposition: inline
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

Quoting "Eric A. Bonney" <mailinglists@vanhlebarsoftware.com>:

> I was able to sucessfully mount the /home directories for my users on
> my home network when they login just fine using autofs. The issue that
> I have now is that I would like to mount some additional NFS exports
> under /home/user but I need to be able to set up some kind of script
> or testing so that I can only mount certain exports depending on
> groups the user belongs to.
>
> I have just the basic configuration for sharing the /home at this point.
>
> In auto.master:
> /home                     /etc/auto.home
>
> In auto.home:
> *                   serveripaddress:/home/&
>
> This is working fine on one machine but not another, but I haven't had
> time to look at the machine that isn't working yet.
>
> An example of what I want to do is this:
> If the user belongs to Kids OR Adults then I want to mount the Music
> directory as such:
> /home/user/Music
>
> If the user is a memeber of Adults only then I want to mount Music and
> Financial as such:
> /home/user/Music
> /home/user/Financial
>
> To be honest at this point I would even take mounting Music off of
> root if that would work, but I can't even get that to work. I have
> tried it like this:
>
> In auto.master:
> /Music                     /etc/auto.music
>
> In auto.music:
> /Music                    serveripaddress:/media/usb0/Music
>
> AND this
> *                         serveripaddress:/media/usb0/Music
>
> Nothing seems to be working other than the mounting of /home. I have
> googled for days and I have read the docs, but I can't seem to figure
> this out. It doesn't seem like it should be that hard, but I seem to
> be making it hard. :)
>
> Thanks for the help.
>
> -Eric
>
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>

I was able to get the direct mount working after upgrading to v5.0.3.  
I still would prefer to have some method of have them mounted  
dynamically under /home/user depending on the user's group. Maybe this  
can be done in some kind of script?

-Eric
