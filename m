From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: New autofs in sid, please push to testing
Date: Fri, 13 May 2005 13:46:09 +0200
Message-ID: <20050513114609.GA22968@uio.no>
References: <20050511115113.GA24295@uio.no>
	<20050513044148.GB4770@mauritius.dodds.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050513044148.GB4770@mauritius.dodds.net>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: debian-release@lists.debian.org
Cc: autofs@linux.kernel.org

On Thu, May 12, 2005 at 09:41:52PM -0700, Steve Langasek wrote:
>> I've uploaded autofs 4.1.3+4.1.4beta2-8 to sid, which fixes (to the best of
>> my knowledge -- I can't reproduce the problems myself) two important bugs,
>> and contains no other changes. vorlon promised me a freeze exception for the
>> upload, so letting it through to sarge would be nice :-) Thanks.
> Hmm, memory leak:
> 
> [...]
>
> ++int is_local_mount(const char *hostpath)
> ++{
>
> [...]
> 
> Memory is allocated for hostname on every call, and never freed.

I've fixed this in 4.1.3+4.1.4beta2-10 (just uploaded); it's a simple fix
(free(hostname) added three or four places -- it's being used in printf()s
etc. in various code branches, so I can't just free it once).

> The get_best_mount function worries me, as it's writing to a caller-provided
> pointer (char *what) with no bounds checking.  This appears to be the
> intended *use* of the pointer, so this isn't a blocking issue, it's just
> something that ought to be cleaned up at some point (including making sure
> there's no exploitable buffer overflow here when using things like LDAP or
> Hesiod maps).

Cc-ing the autofs list :-)

/* Steinar */
-- 
Homepage: http://www.sesse.net/
