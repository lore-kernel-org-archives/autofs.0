From: Ian Kent <raven@themaw.net>
Subject: Re: Question/request about host mapping
Date: Thu, 07 Apr 2011 22:56:16 +0800
Message-ID: <1302188176.2883.39.camel@perseus>
References: <BANLkTimoD2yb7DBvNsrP014yxRaGywQVug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=sKXeccKdPJWz9iJQf09ZxsyAxHI=;
	b=olJd6bvg3eDBXnop8v5ZJGcKjWDJ6KKyRtrMMyVWrFgZtNUMmDqSeutJ2RkwFzvrHvco8AE/Fyotq8TJcs65Bexg93+1typtw4MKxMkQjF+MLEeiLrMXiuaI7fncqIeGitCiGAcBma9DVKXazW9cHKvK6BAO0yrjEVzS6NS/8+0=
In-Reply-To: <BANLkTimoD2yb7DBvNsrP014yxRaGywQVug@mail.gmail.com>
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

On Wed, 2011-04-06 at 12:52 -0600, Michael Coffman wrote:
> Hello,
> 
> I am trying to use the -host map for global access to servers in my
> environment.   
> 
> I have noted on this list that after the first mount of a server via
> host mapping, the server is never again probed for mount points.  This
> seems like a major flaw in the host map functionality.   This is a
> problem when adding new file systems to our NFS servers.   It means
> systems have to be completely idled in order to get them to unmount
> and re-mount the servers to see the new mount points (not possible
> very often in my environment).    
> 
> Is the assumption that if you use host mapping, your server will
> either never change, or you have the ability to 'reboot' your
> environment when a new file system is added to a server?

Neither.

The problem is that exports can be nested and frequently are (think of
the nohide export option).

For example, with exports like:

/export/vol1/data1
/export/vol1/data2

and then add:

/export/vol1

and update the map when either or both /export/vol1/data1
and /export/vol1/data2 are mounted, /export/vol1 is accessed it will
cover these mounts. Now that might not seem like a problem but when you
end up with multiple layers of mounts mounted multiple times everything
starts to get confused really fast.

> 
> Is there any way that functionality could be added that would allow
> for sending a signal ( say USR2 ) that would cause the automounter to
> re-run /etc/auto.net to re-query -host managed servers for new file
> systems?

Well, if you have sensible, realistic, workable ideas on how to handle
the nesting problem then share. And I don't mean "just do this ...."
type through away comments that have no workable basis in fact.

Ian
