From: Ian Kent <raven@themaw.net>
Subject: Re: patch: fix for dynamic logging breaking non-sasl build
Date: Sun, 18 Nov 2007 11:21:49 +0900
Message-ID: <1195352509.3087.0.camel@raven.themaw.net>
References: <473EDD0F.3070705@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <473EDD0F.3070705@inria.fr>
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
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org

On Sat, 2007-11-17 at 13:22 +0100, Guillaume Rousse wrote:
> autofs-5.0.2-dynamic-logging.patch breaks non-sasl enabled build by
> calling autofs_sasl_done unconditonaly in lookup_ldap.c
> 
> Attached patch fix this issue

Right you are.
Thanks Guillaume.
Ian
