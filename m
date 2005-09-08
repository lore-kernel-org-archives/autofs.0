From: Jehan PROCACCIA <Jehan.Procaccia@int-evry.fr>
Subject: Re: correct format for mounting cifs/smbfs shares
Date: Thu, 08 Sep 2005 17:49:11 +0200
Message-ID: <43205D77.7090404@int-evry.fr>
References: <17182.62683.375367.892022@segfault.boston.redhat.com>
	<431F0527.5060701@int-evry.fr>
	<Pine.LNX.4.63.0509072358450.2552@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0509072358450.2552@donald.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent wrote:

>On Wed, 7 Sep 2005, Jehan PROCACCIA wrote:
>  
>
>
>Mount doesn't know how to do this.
>I agree that clear text passwords ar bad.
>Aren't the permissions restrictive enough to protect them?
>
>I don't know what pamcred could do. Let me know if you find a better 
>method.
>  
>
don't know either ... but I suspect that it could help :
http://www.padl.com/OSS/pam_ccreds.html
