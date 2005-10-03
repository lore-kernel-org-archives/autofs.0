From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: swap space (off topic)
Date: Mon, 3 Oct 2005 13:09:49 +0200
Message-ID: <20051003110949.GC26883@uio.no>
References: <215ff4410510030159h205c3588xa432510af1940f3d@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <215ff4410510030159h205c3588xa432510af1940f3d@mail.gmail.com>
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
To: autofs@linux.kernel.org

On Mon, Oct 03, 2005 at 10:59:21AM +0200, Chris Fanning wrote:
> I know this hasn't got much to do with the list but I thought someone
> here might put me in the right direction.

You might want to try debian-user@lists.debian.org. :-)

> I've recently installed a Debian testing. When it boots, it reports
> "activating swap space: failed"

Check that you don't have anything bogus in your /etc/fstab?

> However, I can see swap space using the 'top' command.(although it
> doesn't get used).

If it's there, it's OK, and will eventually get used.

/* Steinar */
-- 
Homepage: http://www.sesse.net/
