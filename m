From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: autofs - nfs with localhost
Date: Fri, 11 Feb 2005 13:14:13 +0100
Message-ID: <20050211121413.GB26099@uio.no>
References: <20050209170812.GA3000@hamburg.neofonie.priv>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050209170812.GA3000@hamburg.neofonie.priv>
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

On Wed, Feb 09, 2005 at 06:08:12PM +0100, Rasmus Hahn wrote:
> For some reason the automounter believes in beeing smarter than me,
> and instead of mounting using the nfs daemon it could find on port 12215
> it uses a `mount --bind' to mount the root filesystem without nfs.

While we're at this; how would this work with NFSv4, which has a virtual
root (ie. localhost:/foo/bar might map to /exports/nfsv4/foo/bar or whatnot)?
Does autofs currently contain support for this?

/* Steinar */
- currently experimenting with NFSv4 a lot, and although it's quite shaky
  it's really promising :-)
-- 
Homepage: http://www.sesse.net/
