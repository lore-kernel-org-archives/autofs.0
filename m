From: raven@themaw.net
Subject: Re: Re: New autofs in sid, please push to testing
Date: Sun, 15 May 2005 22:06:51 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0505152202390.14835@donald.themaw.net>
References: <20050511115113.GA24295@uio.no>
	<20050513044148.GB4770@mauritius.dodds.net>
	<20050513114609.GA22968@uio.no>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050513114609.GA22968@uio.no>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: autofs@linux.kernel.org, debian-release@lists.debian.org

On Fri, 13 May 2005, Steinar H. Gunderson wrote:

> On Thu, May 12, 2005 at 09:41:52PM -0700, Steve Langasek wrote:

snip ...

>> The get_best_mount function worries me, as it's writing to a caller-provided
>> pointer (char *what) with no bounds checking.  This appears to be the
>> intended *use* of the pointer, so this isn't a blocking issue, it's just
>> something that ought to be cleaned up at some point (including making sure
>> there's no exploitable buffer overflow here when using things like LDAP or
>> Hesiod maps).

Perhaps.

I'll have a look but bounds checking should be done way before this so I'm 
not so concerned about this. Checking that it is done at the right spot is 
the important thing (I think it is in the latest release).

Ian
