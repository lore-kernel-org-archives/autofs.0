From: Ian Kent <raven@themaw.net>
Subject: Re: fairly complex nested filesystems question
Date: Fri, 21 Dec 2007 20:44:12 +0900
Message-ID: <1198237452.3488.22.camel@raven.themaw.net>
References: <1198193391.6195.33.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1198193391.6195.33.camel@localhost>
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
To: chris barry <Christopher.Barry@qlogic.com>
Cc: autofs@linux.kernel.org

On Thu, 2007-12-20 at 18:29 -0500, chris barry wrote:
> Greetings,
> 
> I'm trying to create a nested filesystem structure that combines an
> automounted nfs home directory, with bind mounts from the local machine.
> 
> The structure will look like this:
> /
> |-home
>    `-user1        <-(nfs somehost:/home/user1)
>        |-myftp    <-(bind /var/ftp/users/user1)
>        `-pub_ftp  <-(bind /var/ftp/pub)
> 
> The entire structure needs to get automounted as a group on login, and
> then is chrooted as users ftp into this box.
> 
> My auto.master looks like this:
> /home   /etc/auto.home --timeout=30
> 
> My auto.home looks like this:
> *              -fstype=nfs,rw,intr   10.20.30.40:/home/& \
> /home/&/myftp  -fstype=file          :/var/ftp/users/& \
> /home/&/ftp    -fstype=file          :/var/ftp/pub

This is not valid for a couple of reasons.
First the * will match every key and so nothing else will be seen.
The second and third entries aren't valid map entries for an indirect
map either. Even if they were then the & can't be used on the left hand
side of a map entry. This is because the & is replaced by the key that
has been matched and so can't be used within the key itself. The -fstype
should refer to a valid filesystem but I don't think file is a valid
filesystem. If you're intending this to indicate a bind mount then just
leave out the -fstype=file and leave the :<path>. 

Ian
