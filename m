From: Ian Kent <raven@themaw.net>
Subject: Re: autofs4 and NIS
Date: Thu, 1 Jan 2004 12:13:36 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0401011157590.4407-100000@raven.themaw.net>
References: <200401010159.12640.autofs@dylan.me.uk>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200401010159.12640.autofs@dylan.me.uk>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dylan <autofs@dylan.me.uk>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Thu, 1 Jan 2004, Dylan wrote:

> Hello all,
> 
> I'm currently using autofs4 to mount nfs shares. The config files are 
> distributed via NIS, which overall is working without a hitch. I have 
> two related problems, however...

autofs4 is the kernel module.
What version of the daemon package are you using?
Are you using the unmodified version of the kernel module, autofs4?

> 
> It is, obviously, necessary to restart the NIS server from time to time, 
> in order to take account of config changes (usually changes to user 
> accounts.) When I do this, the following occurs:

Yes, but I fail to see how autofs is part of this unless autofs tries to 
contact the NIS server while NIS is not available? Which should be a few 
seconds at most right?

> 
> A: nfs shares which are unmounted become unavailable (cd-ing to the 
> directory results in a 'no such file or directory' error)

What are you saying here. If the NFS server is not available I would say 
this is firly acurate. We are talking about restarting NIS services 
aren't we?

> 
> B: nfs shares which are mounted report stale file handles.

The client has open files on the NFS server and it has gone bye bye. We 
aren't talking about restarting NIS anymore are we?

> 
> I can understand where problem A comes from - and I figure restarting 
> autofs would clear that, but it is not really practical to do on each 
> machine. But I'm not sure why B should happen...?

You shouldn't need to restart autofs. This nees to be investigated and 
fixed. I'm not seeing this myself but most of my clients have stuff 
mounted for extended time and mostly survive.

Maybe there is more going on here than I can gather from the description 
or maybe the particular setup you have is exposing a problem I am unaware 
of, more info perhaps.

Ian
