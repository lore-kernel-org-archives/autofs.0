From: Ian Kent <raven@themaw.net>
Subject: Re: help: rm_unwanted and disappearing symbolink links
 from nfs servers
Date: Thu, 22 Jul 2010 15:54:53 +0800
Message-ID: <1279785293.2986.35.camel@localhost>
References: <AANLkTilfvoSFLvRZCm4kf4NYi6YdrkYhluz4_8WPCAij@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=EzTrfD9/QJiR3Ot+0eiH+I0V3G4=;
	b=n3Zb7Pz1ithFwZ5gUIvnxZltZrTKVypkQ3aC8tIKG5vtWYKaoLxq5tf/L5iak33+At/NL+DpL3xModf0cjL+KwC1PcQ5aujNT8Jode9NwpJNoa3CZbX82kP6+A5XPUQnekxO74rNNtQyuK3vv4IrDIMtskTWo6GRFgc8DOjx45k=
In-Reply-To: <AANLkTilfvoSFLvRZCm4kf4NYi6YdrkYhluz4_8WPCAij@mail.gmail.com>
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
To: marina cacciagrano <mcacciagrano@gmail.com>
Cc: autofs@linux.kernel.org

On Tue, 2010-07-20 at 17:24 +0100, marina cacciagrano wrote:
> Hello,
> I am experiencing some annoying (if not scary) issue with automount
> (autofs-4.1.3-187).
> I am runnung Linux kernel 2.6.9-34 (RedHat RHEL4 update3).
> 
> Files (mainly symbolic links) disappear from nfs mounted volumes.
> This happens randomly.
> I support several machines running the above mentioned kernel version
> and autofs version.
> The kernel on these cannot be updated, as any change in the kernel
> name will prevent the main application from running.
> I noticed that the file disappearance time concide with messages on
> some of the nfs client machines similar to the following:
> 
> Jul 19 00:20:05 flame-b automount[14400]: rm_unwanted: attempting to
> remove files from a mounted directory
> 
> 'googling' for the error message, I found a cuple of interesting
> messages. Two from IBM:
> 
> http://www-01.ibm.com/support/docview.wss?rs=984&uid=swg21260655
> http://www-01.ibm.com/support/docview.wss?ratlid=cctocbody&rs=984&uid=swg21279055

So your using MVFS?
That investigation was very much related to MVFS as far as I can recall.

> 
> which describe the problem so closely to what I am experiencing, that
> I thought I would send them in this mail, even if they seem to
> describe an issue specific to an IBM system.
> 
> A better match to my problem was found in some autofs forum answers.
> In example the following:
> 
> http://www.mail-archive.com/autofs@linux.kernel.org/msg05120.html

And I think that was something that came out of the above investigation,
can't really remember now. In any case the current RHEL-4 autofs v4 will
have any changes that came out of that work.

If you are seeing some other problem related to the kernel walking into
directories when it shouldn't you probably have no choice but to update
autofs and kernel and see if that helps.

> 
> There are other with very similar messages, they all suggest a patch
> which forces autofs to do a check of some sort.
> I do not know how to implement the mentioned patch. I would like to
> know whether there is a version of autofs which implements the patch
> and that can be installed on the 2.6.9-34 kernel. I really need to
> know, as I have seen instances of whole directories desappearing as
> well as symbolic links.
> 
> In the forum I have seen the recurring names of Jeff Moyer, Ian Kent
> and Chris Feist. Is there any chance I can get in touch with any of
> them, and get some help?

Have you thought of logging a RedHat bug?
Either Jeff or myself is likely to be the one to pick it up.
I haven't heard from Chris for some time now, not sure what he is doing.

Ian
