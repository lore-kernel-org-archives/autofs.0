From: Ian Kent <raven@themaw.net>
Subject: Re: "Busy inodes after unmount. Self destruct in 5
	seconds..."
Date: Sat, 10 Apr 2004 21:23:53 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404102119320.5172@raven.themaw.net>
References: <OF602ECAC6.8CFD3CF1-ON85256E71.004B70E0-04256E71.004E8C14@us.ibm.com>
	<Pine.LNX.4.58.0404102054510.5094@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0404102054510.5094@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Raymond Prach <rprach@us.ibm.com>
Cc: autofs@linux.kernel.org

On Sat, 10 Apr 2004, Ian Kent wrote:

> 
> Good question.
> 
> I merged a patch in 4.1.1 that provided replicated server type behaviour.
> The point bieng that it needs to deal with host specs like 
> host1(10),host2(5),host3 and so on. The point of it is to select the best 
> available host to mount from. To do this we have an rpc_ping function. It 
> is set to time out fairly quickly. All the mount requests pass through 
> this code and if none (one in this case) is not available it return a fail 
> and doesn't attempt the mount.
> 

Indeed, to my knowledge (anyone got more info), this has only been tested 
against Linux servers so it's entirely possible that the rpc_ping needs 
more work to function against other OS servers.

Ian
