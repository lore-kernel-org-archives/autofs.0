From: Ian Kent <raven@themaw.net>
Subject: Re: Question/request about host mapping
Date: Mon, 11 Apr 2011 21:31:48 +0800
Message-ID: <1302528708.2806.16.camel@perseus>
References: <BANLkTimoD2yb7DBvNsrP014yxRaGywQVug@mail.gmail.com>
	<1302188176.2883.39.camel@perseus>
	<BANLkTi=45=vB3TX7mMd9zdzjcS2YLEM4GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=AKfehRFbkFSIDITIgFsZjbtN1zU=;
	b=e2IGyGWtgzSLrecwOOfzpUTRuD99h4l7lnKNavR7OpTn/AyyKWD5GKugNZL2Xrn4063Op2OgWxhORavaFX8vsarXweOzJFxQf22BSxHoFn6uUHXmuICaDT5oe+tqDfvQhAhs77DMjl+zeJH9kW/CaSATOzo26WkE4xjSf+LuPLI=
In-Reply-To: <BANLkTi=45=vB3TX7mMd9zdzjcS2YLEM4GA@mail.gmail.com>
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
To: michael.coffman@avagotech.com
Cc: autofs@linux.kernel.org

On Thu, 2011-04-07 at 15:29 -0600, Michael Coffman wrote:
> On Thu, Apr 7, 2011 at 8:56 AM, Ian Kent <raven@themaw.net> wrote:
>         On Wed, 2011-04-06 at 12:52 -0600, Michael Coffman wrote:
>         > Hello,
>         >
>         > I am trying to use the -host map for global access to
>         servers in my
>         > environment.
>         >
>         > I have noted on this list that after the first mount of a
>         server via
>         > host mapping, the server is never again probed for mount
>         points.  This
>         > seems like a major flaw in the host map functionality.
>         This is a
>         > problem when adding new file systems to our NFS servers.
>         It means
>         > systems have to be completely idled in order to get them to
>         unmount
>         > and re-mount the servers to see the new mount points (not
>         possible
>         > very often in my environment).
>         >
>         > Is the assumption that if you use host mapping, your server
>         will
>         > either never change, or you have the ability to 'reboot'
>         your
>         > environment when a new file system is added to a server?
>         
>         
>         Neither.
>         
>         The problem is that exports can be nested and frequently are
>         (think of
>         the nohide export option).
>         
>         For example, with exports like:
>         
>         /export/vol1/data1
>         /export/vol1/data2
>         
>         and then add:
>         
>         /export/vol1
>         
>         and update the map when either or both /export/vol1/data1
>         and /export/vol1/data2 are mounted, /export/vol1 is accessed
>         it will
>         cover these mounts. Now that might not seem like a problem but
>         when you
>         end up with multiple layers of mounts mounted multiple times
>         everything
>         starts to get confused really fast.
>         
>         
> 
> First off, thanks for the reply and the details on the reasoning for
> not automatically re-scanning servers that have been mounted via host
> mapping.    
> 
> I guess in my simple world I would never export a higher level
> directory if sub-directories were already exported.   Do lots or
> people really nest exports to the same sets of client systems?  I will
> have to think about some scenarios and some possibilities of
> algorithms on how to deal with them and get back with you...
> 
> In any case, it seems having a way to ping autofs and have it re-read
> would imply that the admin would have some knowledge of what was being
> requested.
> 
>  
> 
>         >
>         > Is there any way that functionality could be added that
>         would allow
>         > for sending a signal ( say USR2 ) that would cause the
>         automounter to
>         > re-run /etc/auto.net to re-query -host managed servers for
>         new file
>         > systems?
>         
>         
>         Well, if you have sensible, realistic, workable ideas on how
>         to handle
>         the nesting problem then share. And I don't mean "just do
>         this ...."
>         type through away comments that have no workable basis in
>         fact.
>           
> 
> Hopefully this will not come across as me saying 'just do it' :)    We
> have used AMD for years and I would really like to switch to autofs
> and was planning on doing so until this issue came up.   I believe
> that some kind of knob that could be used to refresh the maps on my
> clients so they see new exports when added to the servers would be
> very useful.   Not an automatic re-querying of the servers, but a
> signal that I can bump automount with when I know what changes have
> been made on the other end and want to refresh.

I'll think more about it.
Perhaps, if I can work out some way to check for active mount within
nested set of exports, I could ignore the nested ones on update. The
problem then will be people complaining that "suddenly it stopped seeing
new mounts when I added them".

> 
> Thanks again for taking the time to reply to my message.
> 
>  
> 
>         Ian
>         
>         
> 
> 
> 
> -- 
> -MichaelC
