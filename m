From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: Bug#304226: Re: Bug#304226: outdated rsize,
	wsize overrides
Date: Tue, 12 Apr 2005 13:08:14 +0200
Message-ID: <20050412110814.GA11129@uio.no>
References: <20050411194555.139CED9443922@ninsei.internal.cyberhqz.com>
	<20050411201312.GC24780@uio.no>
	<Pine.LNX.4.58.0504121250380.11391@wombat.indigo.net.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504121250380.11391@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>, 304226@bugs.debian.org
Cc: autofs@linux.kernel.org, Ryan Murray <rmurray@debian.org>, control@bugs.debian.org

tags 304226 - upstream
thanks

On Tue, Apr 12, 2005 at 12:51:32PM +0800, Ian Kent wrote:
>> I'll fix this in the next upload (if there will be any before sarge); sending
>> it upstream as well.
> These options are added by a Debian specific patch.
> 
> They aren't in the tar distribution.

Heh, you're right.

Ryan: Do you know when this became default? After all, sarge will still be
shipping with 2.4 kernels... (Setting them to 32768 could be an acceptable
compromise.) I'm not really sure if setting "async" is the right thing to do
in the general case, while I'm at it...

/* Steinar */
-- 
Homepage: http://www.sesse.net/
