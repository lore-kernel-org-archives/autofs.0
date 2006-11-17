From: Erich Weiler <weiler@soe.ucsc.edu>
Subject: Re: Autofs hang, centos 4.4
Date: Fri, 17 Nov 2006 11:53:23 -0800
Message-ID: <455E1333.5030609@soe.ucsc.edu>
References: <455C8BA8.9070609@soe.ucsc.edu>	
	<x49ac2rxrc1.fsf@segfault.boston.devel.redhat.com>	
	<455CB5F6.9040201@soe.ucsc.edu>
	<1163749264.2993.67.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1163749264.2993.67.camel@localhost>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

> And if you Ctrl-C two or more times does it then stop?

Yeah, I can try Ctrl-C and Ctrl-D and ESC a hundred times and nothing 
happens (if I'm a regular user).  As root if I try to automount 
something that hangs, I can hit Ctrl-C and it quits.

> So it is mount that's hanging but there isn't a way to cancel the mount
> process. Difficult.

That's basically it.  It's weird.  And it wouldn't be a big deal but 
some of these mounts will often be unavailable due to our network 
topology, so our users will likely scream if they can't Ctrl-C out of a 
hung mount process.

-erich
