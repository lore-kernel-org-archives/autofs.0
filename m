From: Greg Bradner <gregb@rhythm.com>
Subject: Re: Strange autofs V4.0 problems
Date: Tue, 03 Feb 2004 10:46:28 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <401FEC84.40704@rhythm.com>
References: <401EB843.5000501@analog.com>
	<C7C7C062-55D7-11D8-B42C-000A95A011F0@qualcomm.com>
	<401EE1BC.2020006@sedona.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <401EE1BC.2020006@sedona.intel.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Michael Blandford <mlblandf@sedona.ch.intel.com>
Cc: autofs@linux.kernel.org, Mike Marion <mmarion@qualcomm.com>, Annie Mckeon <anne.bourgeois@analog.com>

use the 'nonstrict' opition in your auto.net script.

Michael Blandford wrote:

> Mike Marion wrote:
>
>>
>> The fact that you're seeing that in your logs shows that autofs is 
>> working fine.. your host tried to mount the directory and was denied 
>> by the server.  I'm seeing the exact same thing for some new linux 
>> boxes I just installed over the weekend and some of our NetApp 
>> filers, and we're seeing the same thing from some new Solaris hosts 
>> as well.
>>
>> I'm wondering if there's some kind of name/ip caching bug on the 
>> netapps that caches a deny for a very long period if you try to mount 
>> before your netgroups/dns is updated with the new host information.
>
>
>
> If you can mount them by hand on the same box not using autofs, then 
> it seems more likely to be an autofs issue.
>
> Michael
>
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs


-- 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rhythm & Hues
5404 Jandy Place
Los Angeles, CA 90066
Voice: 310 448-7763
Fax:   310 448-7600
gregb@rhythm.com
