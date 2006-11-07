From: Ian Kent <raven@themaw.net>
Subject: Re: problem with autofs
Date: Tue, 07 Nov 2006 16:44:48 +0800
Message-ID: <1162889088.18975.1.camel@localhost>
References: <29c5cd460611060850p4972e906s65990c968db963e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <29c5cd460611060850p4972e906s65990c968db963e4@mail.gmail.com>
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
To: Syed Khader <syedk@google.com>
Cc: autofs@linux.kernel.org

On Mon, 2006-11-06 at 22:20 +0530, Syed Khader wrote:
> Hello Evrybuddy,
>  
> I had configured Openldap and succesfully configured for
> authentication of users.I'm facing problem with autofs.
>  
> I'm using Rhel4.When i say service autofs start it says
>  
> No mount points defined.
>  
> I have written the correct entries in /etc/exports file.
>  
> I have sucessfully mounted directories using /etc/auto.master and
> indirect maps on the client side
> But when i'm using the ldap maps it's giving me problems
> How can i make my autofs service to read the auto.master from LDAP
> Ou=auto.master.
>  
> I have changed in the /etc/nsswitch.conf file to Automount: ldap but
> no use
>  
> when i use service autofs start it says "No mountpoints defined".
>  
> Are they any bugs with RHEL4?
> Or am i going wrong somewhere?

You need to show us your maps.

Ian
