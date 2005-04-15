From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [autofs] Re: [ANNOUNCE] Important update - autofs 4.1.4 release
Date: Fri, 15 Apr 2005 07:49:17 -0400
Message-ID: <16991.43581.861771.904551@segfault.boston.redhat.com>
References: <Pine.LNX.4.62.0504102120390.14539@donald.themaw.net>
	<Pine.LNX.4.62.0504112324510.6384@donald.themaw.net>
	<16989.52849.68024.30163@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0504141357180.7872@wombat.indigo.net.au>
	<Pine.LNX.4.58.0504141410190.8227@wombat.indigo.net.au>
	<16990.24002.650785.141049@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0504151449260.4676@wombat.indigo.net.au>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0504151449260.4676@wombat.indigo.net.au>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>

==> Regarding Re: [autofs] Re: [ANNOUNCE] Important update - autofs 4.1.4 release; Ian Kent <raven@themaw.net> adds:

raven> On Thu, 14 Apr 2005, Jeff Moyer wrote:
>> ==> Regarding Re: [autofs] Re: [ANNOUNCE] Important update - autofs 4.1.4 release; Ian Kent <raven@themaw.net> adds:
>> 
raven> On Thu, 14 Apr 2005, Ian Kent wrote:
>> >> On Wed, 13 Apr 2005, Jeff Moyer wrote:
>> >> 
>> >> > 
>> >> > This new version has regressed since beta2 for /net mounts in my 
>> >> environment.  A simple ls of /net/<filer> will now show the contents of
>> >> > /net/<filer>/exporteddir.  So, for example, we have devfiler which
>> >> exports /vol/vol1.  When I do an ls of /net/devfiler, I get the
>> >> contents of devfiler:/vol/vol1.
>> >> > 
>> >> > Okay, after further debugging, it seems we're not identifying this as
>> >> a multimount entry.  It's getting late, so I'm going to turn this over
>> >> to you.  I think that the checking of first_chunk is bogus.  For
>> >> instance, with the below change, everything works as expected for me.
>> >>
>> >> 
>> >> Cool, I'll check this out and get back.
>> 
raven> Could I have the example map entry that breaks the parse please.
>> 
>> Sheesh, you'd think that I could generate a bug report by now... I'll blame
>> it on the late night thing.  =)
>> 
>> This is an auto.net entry.  Here's what auto.net spits out for this
>> particular host:
>> 
>> -fstype=nfs,hard,intr,nodev,nosuid \
>> /vol/vol1 devfiler:/vol/vol1
>> 
>> I'm guessing you didn't test auto.net against a host that only exported one
>> dir?  Just a guess.  Below are the debug logs.
>> 

raven> I think this should do the trick.

Yes, you're probably right.  Please consider renaming the first_chunk
variable, too!

-Jeff

raven> --- autofs-4.1.4/modules/parse_sun.c.first-multi	Fri Apr 15 14:30:18 2005
raven> +++ autofs-4.1.4/modules/parse_sun.c	Fri Apr 15 14:42:04 2005
raven> @@ -768,6 +768,10 @@ static int check_is_multi(const char *ma
raven>  	int multi = 0;
raven>  	int first_chunk = 0;
 
raven> +	/* If first character is "/" it's a multi-mount */
raven> +	if (*p == '/')
raven> +		return 1;
raven> +
raven>  	while (*p) {
raven>  		p = skipspace(p);
 
