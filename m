From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs hang, centos 4.4
Date: Tue, 21 Nov 2006 22:21:50 +0800
Message-ID: <1164118910.3092.16.camel@localhost>
References: <455C8BA8.9070609@soe.ucsc.edu>
	<x49ac2rxrc1.fsf@segfault.boston.devel.redhat.com>
	<455CB5F6.9040201@soe.ucsc.edu>  <1163749264.2993.67.camel@localhost>
	<1163872272.2973.5.camel@localhost>  <455FB6C3.8060801@soe.ucsc.edu>
	<1163936909.5367.1.camel@localhost>  <4561EAE9.8010704@soe.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4561EAE9.8010704@soe.ucsc.edu>
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

On Mon, 2006-11-20 at 09:50 -0800, Erich Weiler wrote:
> > It would be good to temporarily setup an account the same as root but
> > which uses tcsh as its shell and check that as well.
> 
> Same thing happens.  Root must have some special power to kill hung 
> mounts that regular users don't.  Maybe because the automountd process 
> is owned by root?

Not that I'm aware of.
Don't think the ownership of automount has anything to do with this
issue.

Ian
