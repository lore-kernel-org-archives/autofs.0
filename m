From: Ian Kent <raven@themaw.net>
Subject: Re: Two different security flavours in nfs mount
 auto.master
Date: Mon, 26 Apr 2010 18:30:16 +0800
Message-ID: <1272277816.16431.64.camel@localhost>
References: <4BD5475B.4040106@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=o706+5tnDjcULs02EeYDF/e2pdM=;
	b=XnuXGMb/WOULLTnILT13dZnmfzYQMQzN8LRYARo8bw/rGEhnkQdrmutcsvhL6TMNScsDF0xXjqH5p1jgJVbusB5cTIeyyGSE2JF0q2/6ZL8h9TxUBfHvICLL5kQgb7IvdgTZiIW8FQfL6HCqgKyepT3gcM/z70I1pQHjo0lqlJ4=
In-Reply-To: <4BD5475B.4040106@tudelft.nl>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Richard Smits <R.Smits@tudelft.nl>
Cc: autofs@linux.kernel.org

On Mon, 2010-04-26 at 09:57 +0200, Richard Smits wrote:
> Hello,
> 
> I was wondering if the next example would be possible with the 
> automounter. I have a feeling this is not possible, but maybe there are 
> some options I do not know about.
> 
> I have two nfs servers.
> 
> One with /export with standard nfs export.
> 
> One with /export with krb5 security.
> 
> Now I want to moutn one of the two if a condition is met. The condition 
> I check with the excecutable automounter script.
> 
> That is not my problem.
> 
> The problem is the auto.master file. For a directory, I can have one 
> security flavour. This is my problem. I need two. See below :
> 
> # NFS homedirs
> /home/nfs	/etc/auto.nfs -rw,-fstype=nfs --timeout 60
> 
> /home/nfs is the homedir for the user, I cannot change this because this 
> is in the configuration os samba. (We use winbind for authentication).
> 
> But my auto.nfs script checks if the user has a homedir on the sandard 
> nfs3 server, or has a home on our nfs4/krb5 server.
> 
> But my auto.master isn't ready for this if you know what I mean.
> 
> I need :
> 
> # NFS homedirs
> /home/nfs	/etc/auto.nfs -rw,-fstype=nfs --timeout 60
> /home/nfs	/etc/auto.nfs -rw,-fstype=nfs4,sec=krb5 --timeout 60

Why don't you just return the required options from the program mount
script along with the mount location?

You can see an example of this in /etc/auto.net and in /etc/auto.smb. In
its simplest form it's just "-<comma separated opts> <mount location>"
and get rid of the -fstype option from the master map.

> 
> This does not work :-( I have tried this.
> 
> Any idea if this is possible with the automounter. I am currently 
> looking at pam_mount, but the automounter has my preference.
> 
> Greetings .. Richard
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
