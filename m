From: Stef Bon <stef@bononline.nl>
Subject: Re: Some reload problems.
Date: Mon, 05 May 2008 16:29:18 +0200
Message-ID: <481F19BE.4010806@bononline.nl>
References: <481F1623.1050505@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <481F1623.1050505@bononline.nl>
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
To: autofs@linux.kernel.org

Stef Bon wrote:
>
> Now, there is an (I think reasonable) assumption:
> - when the automount daemon is not started at boottime, the creation of 
> the networkfolders should not be done
> (this construction does not start it, it should already be running)
> - the daemon will start and continu running with an empty master map
> - a reload hasn't much consequences for existing trees.
>
> But what is necessary, is that after any change in the 
> /var/run/autofs/auto.master file, the daemon should get a reload.
>
> Now my experience is that the first issue is ok. There is even a patch 
> for it. (I'm using version 5.0.3)
>   
Sorry, I meant the second issue. The first is an assumption.

SB
