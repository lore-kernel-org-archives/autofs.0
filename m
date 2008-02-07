From: Ian Kent <raven@themaw.net>
Subject: Re: autofs5 for RHEL 4.6 production ready?
Date: Thu, 07 Feb 2008 11:54:56 +0900
Message-ID: <1202352896.3091.8.camel@raven.themaw.net>
References: <47A9E277.80908@schrodinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <47A9E277.80908@schrodinger.com>
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
To: Simon Gao <gao@schrodinger.com>
Cc: autofs@linux.kernel.org


On Wed, 2008-02-06 at 08:38 -0800, Simon Gao wrote:
> Hi,
> 
> RHEL 4.6 installs autofs 4.1.x as default, but includes
> autofs5-5.0.1-0.rc2.55.el4_6.2. Is autofs5 for RHEL 4.6 ready for
> production?

Short answer is yes.

Slightly longer answer is that a bunch of things are scheduled to be
fixed in 4.7. autofs5 in RHEL-4 tracks autofs in RHEL-5, 4.7 will have
the updates going into 5.2.

Ian
