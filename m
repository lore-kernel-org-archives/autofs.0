From: Henrik Schmidt <hbs@ks.informatik.uni-kiel.de>
Subject: Solaris style +auto_home syntax
Date: Thu, 29 Jul 2004 14:46:23 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <4108F19F.6040505@ks.informatik.uni-kiel.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org


Hi,

I want to use something like this
-----------------------------------------

auto.master :
/home	/etc/auto.home


auto.home :
localuser  localhost:/export/home/&
+auto_home
------------------------------------------

+auto_home should add the entries of my Solaris nisplus auto_home map.

I use automount 3.1.7 and have nisplus on linux fully operational.

I can do

auto.master :
/home nisplus auto_home

and it will work. But I want to merge local mounts from /export/home
with network mounts from nisplus. The +auto_home syntax is working on 
Solaris clients but not on my SuSE 9.1 clients. Any hint or is just not
supported ?

Second question : How do I use direct maps with automount on linux ?
Will autofs4 support it ?

Thanks

Henrik


-- 
Henrik Schmidt                  Christian-Albrechts-Universitaet zu Kiel
Institut fuer Informatik        +49 (431) 880 75 - 50 Fax or 43 Phone
Olshausenstr. 40                http://www.ks.informatik.uni-kiel.de
24098 Kiel, Germany             email: hbs@ks.informatik.uni-kiel.de
