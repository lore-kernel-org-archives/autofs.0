From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [ANNOUNCE] autofs 4.1.4 beta2 release
Date: Tue, 15 Feb 2005 16:28:58 +0100
Message-ID: <20050215152858.GB4112@uio.no>
References: <Pine.LNX.4.61.0502142233210.1653@donald.themaw.net>
	<20050215014857.GA26216@uio.no>
	<Pine.LNX.4.61.0502152253120.8175@donald.themaw.net>
	<Pine.LNX.4.61.0502152303450.8273@donald.themaw.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502152303450.8273@donald.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On Tue, Feb 15, 2005 at 11:04:59PM +0800, raven@themaw.net wrote:
>>> - The check for /proc/modules does not seem to have went in (see
>>>   http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=292762).
>> I though I checks this?
>>
>> Or have you changed the bug id?
> I've read the bug report you refer to but if I'm to get it right you need 
> to provide a patch.

http://home.samfundet.no/~sesse/052_292762_dont_lsmod_on_monolithic_kernels
-- as you can see, it checks that /proc/modules exists (which it only does on
kernels with module support) before calling lsmod. Of course, if /proc isn't
mounted, this breaks, but if /proc isn't mounted something is quite broken
anyhow...

/* Steinar */
-- 
Homepage: http://www.sesse.net/
