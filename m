From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: AutoFS / SASL support
Date: Fri, 02 Nov 2007 15:40:43 -0400
Message-ID: <x497il0saf8.fsf@segfault.boston.devel.redhat.com>
References: <E5F741E838FC2043A0B843E48181813806AB742B@MLNYC730MB.amrs.win.ml.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E5F741E838FC2043A0B843E48181813806AB742B@MLNYC730MB.amrs.win.ml.com>
	(Edward Newman's message of "Fri\, 2 Nov 2007 14\:25\:01 -0400")
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
To: "Newman, Edward (GTI)" <edward_newman@ml.com>
Cc: autofs@linux.kernel.org

"Newman, Edward (GTI)" <edward_newman@ml.com> writes:

> Just wanted to confirm whether SASL support is currently broken in 5.0.2
> with all outstanding patches applied. 

Not sure what patches you're talking about, but the git tree is
definitely broken.

>
> Debug of code suggests following issues:
>
> - Makefile has invalid test for HAVE_SASL in configure.in and thus
> doesn't include correct libraries (-z instead of -n in test step)

I'll take your word for it.

> - patched code in connect_to_server in lookup_ldap.c does not call
> auth_init prior to testing for auth_required and thus fails SASL in all
> cases

Yes, that was broken by the following commit:

commit acd6985801f401f8513627a5fd1eb0753c3f2e40
Author: Ian Kent <raven@raven.themaw.net>
Date:   Mon Sep 24 13:07:36 2007 +0800

    - add LDAP_URI, LDAP_TIMEOUT and LDAP_NETWORK_TIMEOUT
      configuration options.

> - order of code sequence currently fails to enable SASL correctly.

Not sure what you mean by this, unless it's just a summary ove the
above points.

> I am also trying to use an existing keytab for Kerberos GSSAPI
> authentication to directory and currently sasl_kinit code appears to
> fail. Haven't worked out exact cause yet but appears to not passing a
> keytab name and environment is not picking up location from krb5.conf.

The code uses the system keytab, though I have a request to allow the
user to specify a keytab file.  We set up the KRB5CCNAME environment
variable, and that should be picked up by the krb5 libs.

How did you configure /etc/autofs_ldap_auth.conf?

> Please confirm above and whether this is being actively worked on at
> this time.

I did the initial work on this, but have not tested since its merge.
I'm glad to hear someone is going to use it!  Are you volunteering to
help fix this?

-Jeff
