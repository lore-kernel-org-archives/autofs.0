From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [ANNOUNCE] autofs 4.1.4 beta2 release
Date: Tue, 15 Feb 2005 16:54:10 +0100
Message-ID: <20050215155410.GA8354@uio.no>
References: <Pine.LNX.4.61.0502142233210.1653@donald.themaw.net>
	<20050215014857.GA26216@uio.no> <20050215020414.GA953@uio.no>
	<20050215140754.GA26814@uio.no>
	<Pine.LNX.4.61.0502152246210.8175@donald.themaw.net>
	<20050215152604.GA4112@uio.no>
	<Pine.LNX.4.61.0502152323340.8319@donald.themaw.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502152323340.8319@donald.themaw.net>
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

On Tue, Feb 15, 2005 at 11:23:54PM +0800, raven@themaw.net wrote:
>> http://home.samfundet.no/~sesse/autofs_handle-upgrades-cleanly.diff is
>> basically what I've done.
> Thanks.

I'll have to change this again, unfortunately; during testing I found a
machine which had been upgraded from 4.1.3-8 to 4.1.3-9 without reboot, and
thus "/etc/init.d/autofs stop" (which I tried to do in my preinst) was
broken.

I'll have to add a debconf notice telling the admin this and then just let
it break if it breaks; it's the only reasonably sane solution I can see.

/* Steinar */
-- 
Homepage: http://www.sesse.net/
