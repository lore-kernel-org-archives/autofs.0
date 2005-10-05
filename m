From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: direct vs indirect maps??
Date: Wed, 5 Oct 2005 03:43:51 +0200
Message-ID: <20051005014351.GA32035@uio.no>
References: <43431528.5060506@eecs.wsu.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <43431528.5060506@eecs.wsu.edu>
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

On Tue, Oct 04, 2005 at 04:50:00PM -0700, Jim Kusznir wrote:
> I've found references to "direct" and "indirect" maps throughout the 
> various autofs documentation.  However, I have not yet found an 
> understandable definition of what the difference is.  Could someone 
> enlighten me?

Direct maps are relative to /, indirect maps are relative to some other path.

(At least that's my understanding of it.)

/* Steinar */
-- 
Homepage: http://www.sesse.net/
