From: Ian Kent <raven@themaw.net>
Subject: Re: AutoFS / SASL support
Date: Sun, 04 Nov 2007 13:29:29 +0900
Message-ID: <1194150569.3112.7.camel@raven.themaw.net>
References: <E5F741E838FC2043A0B843E48181813806AB742B@MLNYC730MB.amrs.win.ml.com>
	<x497il0saf8.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x497il0saf8.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org, "Newman, Edward (GTI)" <edward_newman@ml.com>

On Fri, 2007-11-02 at 15:40 -0400, Jeff Moyer wrote:
> "Newman, Edward (GTI)" <edward_newman@ml.com> writes:
> 
> > Just wanted to confirm whether SASL support is currently broken in 5.0.2
> > with all outstanding patches applied. 

Are you telling us or asking us?

> 
> Not sure what patches you're talking about, but the git tree is
> definitely broken.
> 
> >
> > Debug of code suggests following issues:
> >
> > - Makefile has invalid test for HAVE_SASL in configure.in and thus
> > doesn't include correct libraries (-z instead of -n in test step)
> 
> I'll take your word for it.
> 
> > - patched code in connect_to_server in lookup_ldap.c does not call
> > auth_init prior to testing for auth_required and thus fails SASL in all
> > cases
> 
> Yes, that was broken by the following commit:
> 
> commit acd6985801f401f8513627a5fd1eb0753c3f2e40
> Author: Ian Kent <raven@raven.themaw.net>
> Date:   Mon Sep 24 13:07:36 2007 +0800
> 
>     - add LDAP_URI, LDAP_TIMEOUT and LDAP_NETWORK_TIMEOUT
>       configuration options.

Guilty, thought I maintained the correct sequence of calls.

Ian
