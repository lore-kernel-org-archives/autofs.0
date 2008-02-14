From: Stef Bon <stef@bononline.nl>
Subject: Re: User token activating the mount.
Date: Thu, 14 Feb 2008 09:57:58 +0100
Message-ID: <47B40296.8070403@bononline.nl>
References: <47B05276.6080800@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <47B05276.6080800@bononline.nl>
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
> So good news! With this extra field indicating the user which is
> activating the mount, it is possible
> to do an extra security check. An mount on behalf of an user can only be
> activated by himself. And everybody
> can do a guest mount.
>   
Hi Stef,

this is very good! The automounter is a very powerfull tool, and this 
power can be abused.
It does not check who's activating the mount, and I can imagine that 
this "anybody can mount situation"
is very insecure. The automounter - running under the account root - can 
do anything. Check credentials for example
which are normally hidden to the user activating the mount, and perform 
a mount with these credentials.

So a check on the userid and only performing the action this user is 
allowed to is a good idea!
I will check this out.

Stef
