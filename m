From: Ian Kent <raven@themaw.net>
Subject: Re: [carlst@u.washington.edu: Bug#298649: autofs: Last line
	of auto.master ignored]
Date: Fri, 11 Mar 2005 16:18:31 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0503111616130.14020@wombat.indigo.net.au>
References: <20050309015822.GA18749@uio.no>
Mime-Version: 1.0
In-Reply-To: <20050309015822.GA18749@uio.no>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: autofs@linux.kernel.org

On Wed, 9 Mar 2005, Steinar H. Gunderson wrote:

> Forwarding another bug here -- wasn't this supposed to be fixed in beta2?

No.

This is a different issue.
This is in the init script not in the automount program reading file maps.
I can't remember the original bug report but I thought it refered to file 
maps and I was able to duplicate it.

I'll investigate.

Ian
