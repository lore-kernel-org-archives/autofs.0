From: Greg Earle <earle@isolar.dyndns.org>
Subject: Re: ENOENT on first reference to an automounted file
Date: Sat, 17 Nov 2007 13:25:41 -0800
Message-ID: <A44FC620-7AAA-445C-B93F-13EA66AA7DF7@isolar.dyndns.org>
References: <mailman.446.1194400455.3098.autofs@linux.kernel.org>
Reply-To: autofs@linux.kernel.org
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <mailman.446.1194400455.3098.autofs@linux.kernel.org>
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
To: autofs@linux.kernel.org

On Nov 6, 2007, at 8:53 PM EST, Dan Halbert <halbert@everyzing.com>  
wrote:

> Greg Earle wrote:
>> We use NIS for our maps, but just for fun, I decided to test
>> turning "--ghost" *on* (we default to it off, and we also use
>> "-nobrowse" on our Suns, so we like to keep them consistent),
>> and ...
>>
> Greg, try the latest kernel, 2.6.9-55.0.12, which is now available  
> from
> RedHat and has also gone downstream to various other RH-source-based
> distributions. This works for us. I agree your ghost/non-ghost
> differences are odd and do not match my experience. But I see
> differences also based on client load.

I see that Red Hat just announced/released RHEL 4 Update 6
yesterday:

https://www.redhat.com/archives/nahant-list/2007-November/msg00068.html

It appears that this includes kernel 2.6.9-67.  Can I safely
assume that this new release quashes this pesky ENOENT bug
once and for all?

More interestingly/importantly, RHEL 4 Update 6 includes autofs5
as a "Technology Preview".  How does the autofs5 code in this
new release compare with the mainline code in RHEL 5 Update 1,
and is it considered robust enough to use in a production
environment that depends heavily (as in, "life or death" -
we use the automounter for *everything*) on automounting?

We started our RHEL 4 Update 5 upgrade cycle a month and a
half ago but were stopped dead in our tracks by this bug.

Now that we have a workaround ("--ghost"), we are planning
on pushing ahead, but I need to know whether I should try
recommending that we instead move to Update 6 rather than
continue to use Update 5 with a Band-Aid.

Thanks,

	- Greg
