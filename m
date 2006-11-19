From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs hang, centos 4.4
Date: Sun, 19 Nov 2006 19:48:29 +0800
Message-ID: <1163936909.5367.1.camel@localhost>
References: <455C8BA8.9070609@soe.ucsc.edu>
	<x49ac2rxrc1.fsf@segfault.boston.devel.redhat.com>
	<455CB5F6.9040201@soe.ucsc.edu>  <1163749264.2993.67.camel@localhost>
	<1163872272.2973.5.camel@localhost>  <455FB6C3.8060801@soe.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <455FB6C3.8060801@soe.ucsc.edu>
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

On Sat, 2006-11-18 at 17:43 -0800, Erich Weiler wrote:
> >>> nisMapName: auto.master
> >>> nisMapEntry: ldap:nisMapName=auto.projects,dc=kilokluster,dc=ucsc,dc=edu 
> >>> -browse,hard,intr,rw
> > 
> > Umm.
> > 
> > Browsable map. It may be possible it's not catching Ctrl-C.
> > 
> > I'll check.
> > 
> > And the user shell is?
> 
> tcsh for normal users.  bash shell when root.  If it's an issue of me 
> not using browsable maps I can turn that off, it's not crucial.  I'll 
> test it.
> 
> Thanks for checking!

It would be good to temporarily setup an account the same as root but
which uses tcsh as its shell and check that as well.

Ian
