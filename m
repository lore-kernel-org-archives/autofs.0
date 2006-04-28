From: Ian Kent <raven@themaw.net>
Subject: Re: auto.smb (null) and other issues
Date: Fri, 28 Apr 2006 10:17:41 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0604281005380.2678@raven.themaw.net>
References: <Prayer.1.0.12.0604270338170.1663@amos>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Prayer.1.0.12.0604270338170.1663@amos>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: W1657801@Queens-Belfast.AC.UK
Cc: autofs@linux.kernel.org

On Thu, 27 Apr 2006, W1657801@Queens-Belfast.AC.UK wrote:

> Hi,
> 
> I have come across some issues when try automount samba shares using auto.smb
> on fedora core 5.
> 
> I had to
> 1)Uncomment the smb section in auto.master
> 2)Add hostnames to /etc/hosts to do hostname to ip translation

Not sure about the name translation issue but yes the system must be able 
to translate the names.

> 
> Then to solve some problems I had to 3)change the opts line in auto.smb to
> read opts="-fstype=cifs" 4)apply one line patch to auto.smb to allow the
> system to read shares with spaces - /Disk/ { if (first) { print opts; first=0
> }; print " \\\n\t /" $2, "://" key "/" $2 } + /Disk/ { if (first) { print
> opts; first=0 }; sub(/ /, "\\ ", $2); print " \\\n\t /" $2, "://" key "/" $2 }

I'm aware of the cifs issue.

I believe that support for smbfs mounts has been removed in favour of 
cifs. There should be a fix for this sometime soon.

> 
> Now the real problem is this, when I cd /smb/sigma the shares mount fine (i
> check ed the logfile).
> 
> However WHEN I do an ls -l i get a (null) entry in the listing. Why is this
> here?

Yes. I've just upgraded to FC5 myself and I'm also seeing this.
I've spent some time trying to work out what's going on but haven't been 
able to nail it yet.

You may also see a remount happen immediately after a mount has expired. 

So far it appears this may be due to the hal package. I'm persuing that as 
well.

> 
> Also, can points 3 and 4 above be fixed in the default auto.smb script
> distributed.

Yes. Should be part of the update.

Ian
