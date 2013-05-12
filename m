From: Doug Nazar <nazard@nazar.ca>
Subject: Re: get_proximity() crashes on interfaces with no addresses
Date: Sun, 12 May 2013 16:31:18 -0400
Message-ID: <518FFC16.9090507@nazar.ca>
References: <518FB9DC.3000304@nazar.ca> <CAEySpB5ugEzVKNpZPy1PR5baeoN-Z1auET0W0M_OoQwSjTPVtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070901060106090809000709"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <CAEySpB5ugEzVKNpZPy1PR5baeoN-Z1auET0W0M_OoQwSjTPVtA@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs@vger.kernel.org

This is a multi-part message in MIME format.
--------------070901060106090809000709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 5/12/2013 2:26 PM, Leonardo Chiquitto wrote:
> On Sun, May 12, 2013 at 5:48 PM, Doug Nazar <nazard@nazar.ca> wrote:
>> Since commit aa6f7793 [autofs-5.0.7 - fix ipv6 proximity calculation] uses
>> getifaddrs however it crashes on interfaces with no addresses. Fix the NULL
>> check to ignore interfaces with no addresses.
> Your patch removes the check on ifa_addr->sa_data. I'm wondering if
> it's possible to have a valid ifa_addr and a NULL sa_data. Do you know?
> Maybe it's safer to just test both:

I don't see how. ifa_addr is of type struct sockaddr. The sa_data field 
is a char array and only has meaning after interpreting the sa_family field.

>> Should it also check for the IFF_UP flag?
> I think it makes sense to test it.
>

Ok, here you go.

Doug


--------------070901060106090809000709
Content-Type: text/plain; charset=windows-1252;
 name="autofs-5.0.7-fix-interface-address-null-check2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="autofs-5.0.7-fix-interface-address-null-check2.patch"

commit d0b5d4961004a41f6881b2ac2bb32ba3002654e5
Author: Doug Nazar <nazard@nazar.ca>
Date:   Sun May 12 16:22:04 2013 -0400

    Since commit aa6f7793 [autofs-5.0.7 - fix ipv6 proximity calculation]
    get_proximity() uses getifaddrs however it crashes on interfaces with no
    addresses. Fix the NULL check to ignore interfaces with no addresses.
    
    Also skip interfaces which are not currently running.

diff --git a/modules/replicated.c b/modules/replicated.c
index 26f64b8..6dbdade 100644
--- a/modules/replicated.c
+++ b/modules/replicated.c
@@ -165,8 +165,9 @@ static unsigned int get_proximity(struct sockaddr *host_addr)
 
 	this = ifa;
 	while (this) {
-		if (this->ifa_flags & IFF_POINTOPOINT ||
-		    this->ifa_addr->sa_data == NULL) {
+		if (!(this->ifa_flags & IFF_UP) ||
+		    this->ifa_flags & IFF_POINTOPOINT ||
+		    this->ifa_addr == NULL) {
 			this = this->ifa_next;
 			continue;
 		}
@@ -202,8 +203,9 @@ static unsigned int get_proximity(struct sockaddr *host_addr)
 
 	this = ifa;
 	while (this) {
-		if (this->ifa_flags & IFF_POINTOPOINT ||
-		    this->ifa_addr->sa_data == NULL) {
+		if (!(this->ifa_flags & IFF_UP) ||
+		    this->ifa_flags & IFF_POINTOPOINT ||
+		    this->ifa_addr == NULL) {
 			this = this->ifa_next;
 			continue;
 		}

--------------070901060106090809000709--
