From: Brian Long <brilong@cisco.com>
Subject: Re: direct map shut down?
Date: Fri, 20 Feb 2004 08:44:54 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1077284694.21595.54.camel@brilong-lnx2.cisco.com>
References: <1077211015.19371.32.camel@brilong-lnx2.cisco.com>
	 <1077211301.19371.34.camel@brilong-lnx2.cisco.com>
	 <Pine.LNX.4.58.0402202058120.4573@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402202058120.4573@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org


> 4.03 is an old version of autofs4. Current is 4.04.
> Strange to see it in RHEL. I thought they didn't want to include it.

The didn't include it in their stock kernel.  They put all their
"unsupported" stuff into an RPM called kernel-unsupported.  I ripped
autofs4.o out of it and loaded it on my system for testing.  I was
hoping direct maps in your later versions might support the multiple
mounts I need.  I'll look into using the multimount functionality.

Do you have plans to get multiple mounts working with direct maps in the
near future?  Will this involve kernel-module changes or just user-land
tool changes?

Thanks.

/Brian/
-- 
       Brian Long                      |         |           |
       Americas IT Hosting Sys Admin   |       .|||.       .|||.
       Cisco Linux Developer           |   ..:|||||||:...:|||||||:..
       Phone: (919) 392-7363           |   C i s c o   S y s t e m s
