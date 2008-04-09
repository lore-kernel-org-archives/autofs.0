From: "Paul B. Henson" <henson@acm.org>
Subject: Re: error returned upon mount failure
Date: Wed, 9 Apr 2008 12:57:59 -0700 (PDT)
Message-ID: <Pine.GSO.4.55.0804091251270.21508@loogie.intranet.csupomona.edu>
References: <Pine.GSO.4.55.0804081730320.21655@loogie.intranet.csupomona.edu>
	<1207714911.2992.15.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1207714911.2992.15.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Tue, 8 Apr 2008, Ian Kent wrote:

> Not at the moment. This has been a known limitation for a long time.
[...]
> So, bottom line is, I'm aware of it and I'm working on it and it looks
> like it will be a while, sorry.

I didn't realize it was a known issue; I hadn't found anything mentioning
it. It was a pretty weird case anyway, I was mounting a ZFS volume, and had
x set in the ACL, but with ZFS ACLs that doesn't allow you to stat the
directory which resulted in the permission denied problem. I had to add a
couple other letters of the alphabet in the ACL (NFSv4 ACLs have a *lot* of
permissions available)...

Thanks for the explanation...


-- 
Paul B. Henson  |  (909) 979-6361  |  http://www.csupomona.edu/~henson/
Operating Systems and Network Analyst  |  henson@csupomona.edu
California State Polytechnic University  |  Pomona CA 91768
