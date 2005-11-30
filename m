From: Ian Kent <raven@themaw.net>
Subject: Re: [RFC PATCH]autofs4: hang and proposed fix
Date: Thu, 1 Dec 2005 00:27:18 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0512010026220.2069@donald.themaw.net>
References: <20051116101740.GA9551@RAM>
	<17292.64892.680738.833917@segfault.boston.redhat.com>
	<1133315771.8978.65.camel@lade.trondhjem.org> 
	<17293.10094.111804.682032@segfault.boston.redhat.com> 
	<1133331286.8195.29.camel@lade.trondhjem.org>
	<Pine.LNX.4.63.0511302334390.2069@donald.themaw.net>
	<1133366016.8625.19.camel@lade.trondhjem.org>
	<Pine.LNX.4.63.0511302358370.2069@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0511302358370.2069@donald.themaw.net>
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
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Thu, 1 Dec 2005, Ian Kent wrote:

> 
> If a call such as sys_mkdir (perhaps in lookup_create) was able to 
> determine the directory exists before taking the semaphore the problem we 
> have here goes away.

Sorry, that's rubbish, ignore it.

Ian
