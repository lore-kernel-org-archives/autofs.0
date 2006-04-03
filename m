From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: Problems with automounts dying
Date: Mon, 3 Apr 2006 03:36:40 +0200
Message-ID: <20060403013640.GA13912@uio.no>
References: <20060326140544.GA5749@uio.no>
	<Pine.LNX.4.64.0604030929090.2400@eagle.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604030929090.2400@eagle.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Mon, Apr 03, 2006 at 09:35:18AM +0800, Ian Kent wrote:
> Ya. Chasing this one for a while now.
> The bug report really looks like stale dentries in the mount point 
> directory but I thought we fixed that. I'll think about it some more.

Thanks. I've asked the submitter for a --debug log, but I haven't received
any answer yet.

/* Steinar */
-- 
Homepage: http://www.sesse.net/
