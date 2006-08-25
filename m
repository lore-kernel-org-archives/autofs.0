From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: autofs5: unable to locate ldap master map
Date: Fri, 25 Aug 2006 09:27:41 +0200
Message-ID: <44EEA66D.1090905@inria.fr>
References: <44A25311.2040501@inria.fr>
	<1151554184.2929.45.camel@raven.themaw.net>
	<44A3B6CD.5030403@inria.fr>
	<1151585997.3915.36.camel@raven.themaw.net>
	<44A4E38D.7020004@inria.fr>
	<Pine.LNX.4.64.0607020143300.11953@raven.themaw.net>
	<44A9216F.1030102@inria.fr>
	<1151943337.9183.44.camel@raven.themaw.net>
	<44C72411.8070401@inria.fr> <44EC6C56.9070304@inria.fr>
	<44EDBC7D.9090702@inria.fr> <E1GGUde-0004ps-00@mta2.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E1GGUde-0004ps-00@mta2.cl.cam.ac.uk>
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
To: autofs mailing list <autofs@linux.kernel.org>

Piete.Brooks--autofs@cl.cam.ac.uk wrote:
>> BTW, I'm not even sure being able to define ldap autentification file
>> name is really useful. I'd just hardcode its location, as the main one.
> 
> I'd really rather not!
Do you really have an use to be able to define your ldap connection
settings in a file named differently from "autofs_ldap_auth.conf" ?

[..]
> PS: LDAP failed for me too until I edited /etc/sysconfig/autofs to use the 
> correct schema -- now it works fine!
Even without configuring the top dn explicitely ?


> ivatt:~: ldapsearch -LLL -x "(&(objectclass=automountMap)(ou=auto.master))"
> dn: ou=auto.master,dc=cl,dc=cam,dc=ac,dc=uk
> objectClass: top
> objectClass: automountMap
> automountMapName: auto.master
> ou: auto.master
> 
> ivatt:~: ldapsearch -LLL -x "(&(objectclass=nisMap)(nisMapName=auto.master))"
> ivatt:~: 
> 
> Any chance of it it defaulting to try the three example schemas?
Which would means having multiple default values for a configuration
directive that only accept one... It may be practical, but rather messy.

-- 
Guillaume Rousse
Projet Estime, INRIA
Domaine de Voluceau
Rocquencourt - B.P. 105
78153 Le Chesnay Cedex - France
