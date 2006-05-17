From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs 5.0.0 beta2
Date: Wed, 17 May 2006 10:57:43 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0605171055390.24160@raven.themaw.net>
References: <Pine.LNX.4.64.0605091848390.12829@raven.themaw.net>
	<446251C5.5070407@inria.fr>
	<Pine.LNX.4.64.0605171035370.20033@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605171035370.20033@raven.themaw.net>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org

On Wed, 17 May 2006, Ian Kent wrote:

> 
> > - autofs-4.1.1-get-best-mount.patch refer to a 4 args get_best_mount()
> > function that only has 3 args nowadays
> 
> This patch makes get_best_mount use a long timeout always instead of a 
> short timeout followed by long timeout if it the first rpc_ping fails.
> 
> I think that get_best_mount was not falling back to the long timeout so 
> this patch was used to work around it. I'm fairly sure that was fixed.
> 
> Anyway, get_best_mount will go away soon as the server selection code is 
> being re-written.
> 

Oh .. nearly forgot.

If you really want to continue to use this patch to force the use of a 
long timeout then I think removing the fourth parameter is all that is 
needed.

Ian
