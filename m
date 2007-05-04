From: "Douglas E. Engert" <deengert@anl.gov>
Subject: Re: Simple BINDS over SSL/TLS
Date: Fri, 04 May 2007 11:19:30 -0500
Message-ID: <463B5D12.9070901@anl.gov>
References: <20070502151939.GD9348@cartman.devries.tv>	<20070502153310.GF9348@cartman.devries.tv>
	<4639F837.9030606@anl.gov>	<x497irpinp9.fsf@segfault.boston.devel.redhat.com>	<463B42C1.8000301@anl.gov>
	<x49y7k4hcgo.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49y7k4hcgo.fsf@segfault.boston.devel.redhat.com>
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
Cc: autofs@linux.kernel.org



Jeff Moyer wrote:
> ==> On Fri, 04 May 2007 09:27:13 -0500, "Douglas E. Engert" <deengert@anl.gov> said:
> 
> Douglas> Jeff Moyer wrote: > ==> On Thu, 03 May 2007 09:56:55 -0500,
> Douglas> "Douglas E. Engert" <deengert@anl.gov> said: > Douglas> I had
> Douglas> a working patch, but got side tracked. Are there any >
> Douglas> Douglas> plans to add SASL support to autofs, such that it
> Douglas> ends up in > Douglas> Debian distribution?  > SASL support
> Douglas> was introduced in autofs v5.  Testing has been limited, >
> Douglas> since it seems no one uses it.
> 
> Douglas> Great. I was looking at Debian, and using a Ubuntu system,
> Douglas> that used 4.1.4 When v5 is stable, then we can look at it
> Douglas> again. Is v5 in any of the RedHat distributions?
> 
> I use v5 on my workstation, and have done so for at least a couple of
> months, now.  We also ship it in several distributions, so let's call
> it stable.  If you have evidence to the contrary, then please send us
> problem reports!

I have no indications of any problems. What I meant was "stable"
in the terms of the Debian distributions. Debian appears to have 4.1.4
versions in "stable", "testing" and "unstable"
Unfortuneatly they don't appear to have any 5.0 versions yet.


 
http://packages.debian.org/cgi-bin/search_packages.pl?searchon=names&version=all&exact=1&keywords=autofs

> 
> It is available in RHEL 5, FC6, and will be shipping with F7 as well.

Good to know, we have a number of RedHat systems too.
> 
> -Jeff
> 
> 

-- 

  Douglas E. Engert  <DEEngert@anl.gov>
  Argonne National Laboratory
  9700 South Cass Avenue
  Argonne, Illinois  60439
  (630) 252-5444
