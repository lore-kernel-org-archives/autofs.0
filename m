From: Michael Blandford <mlblandf@sedona.ch.intel.com>
Subject: Re: Strange autofs V4.0 problems
Date: Mon, 02 Feb 2004 16:48:12 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <401EE1BC.2020006@sedona.intel.com>
References: <401EB843.5000501@analog.com>
	<C7C7C062-55D7-11D8-B42C-000A95A011F0@qualcomm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <C7C7C062-55D7-11D8-B42C-000A95A011F0@qualcomm.com>
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
To: Mike Marion <mmarion@qualcomm.com>
Cc: autofs@linux.kernel.org, Annie Mckeon <anne.bourgeois@analog.com>

Mike Marion wrote:

>
> The fact that you're seeing that in your logs shows that autofs is 
> working fine.. your host tried to mount the directory and was denied 
> by the server.  I'm seeing the exact same thing for some new linux 
> boxes I just installed over the weekend and some of our NetApp filers, 
> and we're seeing the same thing from some new Solaris hosts as well.
>
> I'm wondering if there's some kind of name/ip caching bug on the 
> netapps that caches a deny for a very long period if you try to mount 
> before your netgroups/dns is updated with the new host information.


If you can mount them by hand on the same box not using autofs, then it 
seems more likely to be an autofs issue.

Michael
