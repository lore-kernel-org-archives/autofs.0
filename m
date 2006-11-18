From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs hang, centos 4.4
Date: Sat, 18 Nov 2006 15:33:46 +0800
Message-ID: <1163835226.2973.1.camel@localhost>
References: <455C8BA8.9070609@soe.ucsc.edu>
	<x49ac2rxrc1.fsf@segfault.boston.devel.redhat.com>
	<455CB5F6.9040201@soe.ucsc.edu> <1163749264.2993.67.camel@localhost>
	<455E1333.5030609@soe.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <455E1333.5030609@soe.ucsc.edu>
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
To: Erich Weiler <weiler@soe.ucsc.edu>
Cc: autofs@linux.kernel.org

On Fri, 2006-11-17 at 11:53 -0800, Erich Weiler wrote:
> > And if you Ctrl-C two or more times does it then stop?
> 
> Yeah, I can try Ctrl-C and Ctrl-D and ESC a hundred times and nothing 
> happens (if I'm a regular user).  As root if I try to automount 
> something that hangs, I can hit Ctrl-C and it quits.
> 

Obvious but I have to ask.
Does your login script disable ctrl-c and not reinstate it?

Ian
