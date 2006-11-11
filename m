From: Ian Kent <raven@themaw.net>
Subject: Re: autofs to load MAP from LDAP
Date: Sat, 11 Nov 2006 10:44:28 +0800
Message-ID: <1163213068.3113.10.camel@localhost>
References: <29c5cd460611082119u63dcc765j56c58c07f6ccd072@mail.gmail.com>
	<1163077907.9612.18.camel@houuc8>
	<29c5cd460611092033m2e0de71cpa6e9e29d74555c24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <29c5cd460611092033m2e0de71cpa6e9e29d74555c24@mail.gmail.com>
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

On Fri, 2006-11-10 at 10:03 +0530, Syed Khader wrote:
> But in my ldap entries i don't have automountmapname.

Stephen said in his post that he is using a different schema.

> 
> dn: ou=auto.master,dc=testlab,dc=com
> objectClass:top
> objectClass:automountMap
> ou:auto.master
>  
> dn: cn=/home,ou=auto.master,dc=testlab,dc=com
> objectClass:automount
> cn:/home
> automountInformation: ldap
> server.testlab.com:ou=auto.home,dc=testlab,dc=com --timeout 60
>  
>  
> Auto.Home
>  
> dn: ou=auto.home,dc=testlab,dc=com
> objectClass:top
> objectClass:automountMap
> ou:auto.home
>  
> dn: cn=user1,ou=auto.home,dc=testlab,dc=com
> objectClass: automount
> cn:user1
> automountInformation: -fstype=nfs,hard,intr
> server.testlab.com:/home/user1
>  
> What do i set LDAPAUTOMASTER to?
> 
> Abdul.
> 
> 
> 
> On 11/9/06, Stephen C. Rigler <srigler@marathonoil.com> wrote:
>         On Thu, 2006-11-09 at 10:49 +0530, Syed Khader wrote:
>         > Hello Everybody,
>         > 
>         > How to make autofs read map from ldap rather than files.
>         > 
>         
>         Syed,
>         
>         We run a mixed environment of Irix, Solaris and Linux
>         machines.  To keep the Solaris machines happy, we use their
>         schema (keys are "automountkey" rather than "cn", etc).  With
>         autofs-4, Linux needs a different master map, but with version
>         5 it looks like we'll be able to use the same map as the other
>         platforms. 
>         
>         To point the Linux machines at your master map set
>         "LDAPAUTOMASTER" in /etc/sysconfig/autofs to the name of the
>         map (the name, not the dn).
>         
>         Our master map looks like:
>         
>         dn: automountMapName=auto.master_linux,dc=example,dc=com
>         automountMapName: auto.master_linux
>         objectClass: top
>         objectClass: automountMap
>         
>         dn:
>         automountkey=/home,automountmapname=auto.master_linux,dc=example,dc=com
>         objectClass: automount
>         objectClass: top
>         automountKey: /home
>         automountInformation:
>         ldap:automountmapname=auto_home,dc=example,dc=com
>         
>         auto_home looks like:
>         
>         dn: automountMapName=auto_home,dc=example,dc=com
>         automountMapName: auto_home
>         objectClass: top
>         objectClass: automountMap
>         
>         dn:
>         automountkey=someuser,automountmapname=auto_home,dc=example,dc=com
>         objectClass: automount
>         objectClass: top
>         automountKey: someuser
>         automountInformation: -rw    server:/export/home/&
>         
>         Hope this helps.
>         
>         -Steve
>         
>         
>         
>         _______________________________________________
>         autofs mailing list
>         autofs@linux.kernel.org
>         http://linux.kernel.org/mailman/listinfo/autofs
>         
>         
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
