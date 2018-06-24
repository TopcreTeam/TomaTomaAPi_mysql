CREATE TABLE tm_user
(
    `u_id`         VARCHAR(50)     NOT NULL    COMMENT '이메일(계정아이디)', 
    `u_pw`         VARCHAR(20)     NOT NULL    COMMENT '비밀번호', 
    `u_name`       VARCHAR(20)     NOT NULL    COMMENT '이름', 
    `u_phone`      VARCHAR(20)     NOT NULL    COMMENT '연락처', 
    `u_addr1`      VARCHAR(200)    NOT NULL    COMMENT '배송지1', 
    `u_addr2`      VARCHAR(200)    NOT NULL    DEFAULT '''N''' COMMENT '배송지2', 
    `u_addr3`      VARCHAR(200)    NOT NULL    DEFAULT '''N''' COMMENT '배송지3', 
    `u_addrcheck`  INT                  NOT NULL    DEFAULT 1 COMMENT '현재주소표시', 
    `u_birth`      VARCHAR(20)     NOT NULL    COMMENT '주민번호앞자리', 
    `u_gender`     CHAR(1)         NOT NULL    COMMENT '성별', 
    `u_smsyn`      CHAR(1)         NOT NULL    COMMENT 'sms수신동의여부', 
    `u_emailyn`    CHAR(1)         NOT NULL    COMMENT '이메일 수신동의여부', 
    `u_joindate`   DATE                 DEFAULT now() NOT NULL     COMMENT '가입일', 
    `useyn`        CHAR(1)              NULL, 
    PRIMARY KEY (u_id)
);

ALTER TABLE tm_user COMMENT '회원';

CREATE INDEX tm_user_pk ON tm_user
(
    u_id
);


-- tm_product Table Create SQL
CREATE TABLE tm_product
(
    `p_code`       VARCHAR(10)      NOT NULL    COMMENT '상품코드', 
    `p_name`       VARCHAR(20)      NOT NULL    COMMENT '상품명', 
    `p_count`      INT                   NOT NULL    COMMENT '상품재고', 
    `p_kind`       VARCHAR(30)      NOT NULL    COMMENT '상품종류', 
    `p_price`      INT                   NOT NULL    COMMENT '원가', 
    `p_sellprice`  INT                   NOT NULL    COMMENT '판매가', 
    `p_profit`     INT                   NOT NULL    COMMENT '수익', 
    `p_content`    VARCHAR(4000)    NOT NULL    COMMENT '상품내용', 
    `p_img`        VARCHAR(200)     NOT NULL    COMMENT '상품이미지', 
    `p_date`       DATE                 DEFAULT now() NOT NULL, 
    `useyn`        CHAR(1)               NOT NULL, 
    PRIMARY KEY (p_code)
);

ALTER TABLE tm_product COMMENT '상품';

CREATE INDEX tm_product_pk ON tm_product
(
    p_code
);


-- tm_admin Table Create SQL
CREATE TABLE tm_admin
(
    `a_id`        VARCHAR(20)    NOT NULL    COMMENT '직원ID', 
    `a_pw`        VARCHAR(20)    NOT NULL    COMMENT '패스워드', 
    `a_name`      VARCHAR(20)    NOT NULL    COMMENT '직원이름', 
    `a_position`  VARCHAR(20)    NOT NULL    COMMENT '직급', 
    `a_job`       VARCHAR(20)    NOT NULL    COMMENT '직무', 
    `a_email`     VARCHAR(50)    NOT NULL    COMMENT '이메일주소', 
    `a_phone`     VARCHAR(20)    NOT NULL    COMMENT '연락처', 
    `useyn`       CHAR(1)             NOT NULL, 
    PRIMARY KEY (a_id)
);

ALTER TABLE tm_admin COMMENT '관리자';

CREATE INDEX tm_admin_pk ON tm_admin
(
    a_id
);


-- tm_order Table Create SQL
CREATE TABLE tm_order
(
    `o_no`      INT                  NOT NULL    AUTO_INCREMENT COMMENT '주문번호', 
    `u_id`      VARCHAR(50)     NOT NULL    COMMENT '이메일(계정아이디)', 
    `o_total`   INT                  NOT NULL    COMMENT '총 가격', 
    `o_status`  CHAR(1)         NOT NULL    DEFAULT '''N''' COMMENT '주문현황', 
    `o_date`    DATE            DEFAULT now() NOT NULL COMMENT '주문일자', 
    `o_addr`    VARCHAR(200)    NULL, 
    `useyn`     CHAR(1)              NOT NULL, 
    PRIMARY KEY (o_no)
);

ALTER TABLE tm_order COMMENT '주문';

CREATE INDEX tm_order_pk ON tm_order
(
    o_no
);

ALTER TABLE tm_order ADD CONSTRAINT FK_tm_order_u_id_tm_user_u_id FOREIGN KEY (u_id)
 REFERENCES tm_user (u_id)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- tm_cart Table Create SQL
CREATE TABLE tm_cart
(
    `c_no`      INT                 NOT NULL    AUTO_INCREMENT COMMENT '카트번호', 
    `u_id`      VARCHAR(50)    NOT NULL    COMMENT '이메일(계정아이디)', 
    `p_code`    VARCHAR(10)    NOT NULL    COMMENT '상품코드', 
    `c_amount`  INT                 NOT NULL    COMMENT '수량', 
    PRIMARY KEY (c_no)
);

ALTER TABLE tm_cart COMMENT '장바구니';

CREATE INDEX tm_cart_pk ON tm_cart
(
    c_no
);

ALTER TABLE tm_cart ADD CONSTRAINT FK_tm_cart_p_code_tm_product_p_code FOREIGN KEY (p_code)
 REFERENCES tm_product (p_code)  ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tm_cart ADD CONSTRAINT FK_tm_cart_u_id_tm_user_u_id FOREIGN KEY (u_id)
 REFERENCES tm_user (u_id)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- tm_faq Table Create SQL
CREATE TABLE tm_faq
(
    `f_no`        INT                   NOT NULL    AUTO_INCREMENT COMMENT '게시글번호', 
    `f_category`  VARCHAR(20)      NOT NULL    COMMENT '카테고리', 
    `f_title`     VARCHAR(200)     NOT NULL    COMMENT '제목', 
    `f_content`   VARCHAR(4000)    NOT NULL    COMMENT '내용', 
    `a_id`        VARCHAR(20)      NOT NULL    COMMENT '작성자', 
    `f_hits`      INT                   NOT NULL    COMMENT '조회수', 
    `f_date`      DATE                  DEFAULT now() NOT NULL COMMENT '작성일', 
    PRIMARY KEY (f_no)
);

ALTER TABLE tm_faq COMMENT '자주묻는 질문';

CREATE INDEX tm_faq_pk ON tm_faq
(
    f_no
);

ALTER TABLE tm_faq ADD CONSTRAINT FK_tm_faq_a_id_tm_admin_a_id FOREIGN KEY (a_id)
 REFERENCES tm_admin (a_id)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- tm_notice Table Create SQL
CREATE TABLE tm_notice
(
    `n_no`        INT                   NOT NULL    AUTO_INCREMENT COMMENT '게시글번호', 
    `n_category`  VARCHAR(20)      NOT NULL    COMMENT '카테고리', 
    `n_title`     VARCHAR(200)   	NOT NULL    COMMENT '제목', 
    `n_content`   VARCHAR(4000)    NOT NULL    COMMENT '내용', 
    `a_id`        VARCHAR(20)      NOT NULL    COMMENT '직원ID', 
    `n_hits`      INT                   NOT NULL    COMMENT '조회수', 
    `n_date`      DATE                 DEFAULT now() NOT NULL COMMENT '작성일', 
    PRIMARY KEY (n_no)
);

ALTER TABLE tm_notice COMMENT '공지사항';

CREATE INDEX tm_notice_pk ON tm_notice
(
    n_no
);

ALTER TABLE tm_notice ADD CONSTRAINT FK_tm_notice_a_id_tm_admin_a_id FOREIGN KEY (a_id)
 REFERENCES tm_admin (a_id)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- tm_order_detail Table Create SQL
CREATE TABLE tm_order_detail
(
    `od_no`       INT                  NOT NULL    AUTO_INCREMENT COMMENT '주문상세번호', 
    `o_no`        INT                  NOT NULL    COMMENT '주문번호', 
    `od_img`      VARCHAR(200)    NOT NULL    COMMENT '상품이미지', 
    `od_pname`    VARCHAR(20)     NOT NULL    COMMENT '상품명', 
    `od_pprice`   INT                  NOT NULL    COMMENT '상품가격', 
    `od_pamount`  INT                  NOT NULL    COMMENT '수량', 
    PRIMARY KEY (od_no)
);

ALTER TABLE tm_order_detail COMMENT '주문상세';

CREATE INDEX tm_order_detail_pk ON tm_order_detail
(
    od_no
);

ALTER TABLE tm_order_detail ADD CONSTRAINT FK_tm_order_detail_o_no_tm_order_o_no FOREIGN KEY (o_no)
 REFERENCES tm_order (o_no)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- tm_product_qna Table Create SQL
CREATE TABLE tm_product_qna
(
    `pq_no`        INT              NOT NULL    AUTO_INCREMENT, 
    `pq_category`  VARCHAR(20)      NOT NULL, 
    `pq_title`     VARCHAR(100)     NOT NULL, 
    `pq_content`   VARCHAR(4000)    NOT NULL, 
    `pq_reply`     VARCHAR(4000)    NOT NULL, 
    `pq_replyyn`   CHAR(1)          NOT NULL, 
    `pq_hits`      INT               NOT NULL, 
    `p_code`       VARCHAR(10)      NOT NULL, 
    `u_id`         VARCHAR(50)      NOT NULL, 
    `pq_date`      DATE                 DEFAULT now() NOT NULL, 
    PRIMARY KEY (pq_no)
);

CREATE INDEX tm_product_qna_pk ON tm_product_qna
(
    pq_no
);

ALTER TABLE tm_product_qna ADD CONSTRAINT FK_tm_product_qna_p_code_tm_product_p_code FOREIGN KEY (p_code)
 REFERENCES tm_product (p_code)  ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tm_product_qna ADD CONSTRAINT FK_tm_product_qna_u_id_tm_user_u_id FOREIGN KEY (u_id)
 REFERENCES tm_user (u_id)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- tm_product_review Table Create SQL
CREATE TABLE tm_product_review
(
    `rev_no`       INT               NOT NULL    AUTO_INCREMENT, 
    `rev_title`    VARCHAR(100)     NOT NULL, 
    `rev_content`  VARCHAR(4000)    NOT NULL, 
    `rev_hits`     INT               NULL, 
    `p_code`       VARCHAR(10)      NOT NULL, 
    `u_id`         VARCHAR(50)      NOT NULL, 
    `rev_date`     DATE                 DEFAULT now() NOT NULL, 
    PRIMARY KEY (rev_no)
);

CREATE INDEX tm_product_review_pk ON tm_product_review
(
    rev_no
);

ALTER TABLE tm_product_review ADD CONSTRAINT FK_tm_product_review_p_code_tm_product_p_code FOREIGN KEY (p_code)
 REFERENCES tm_product (p_code)  ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tm_product_review ADD CONSTRAINT FK_tm_product_review_u_id_tm_user_u_id FOREIGN KEY (u_id)
 REFERENCES tm_user (u_id)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- tm_qna Table Create SQL
CREATE TABLE tm_qna
(
    `q_no`       INT                   NOT NULL    AUTO_INCREMENT COMMENT '질문번호', 
    `q_title`    VARCHAR(200)     NOT NULL    COMMENT '질문명', 
    `q_content`  VARCHAR(4000)    NOT NULL    COMMENT '질문내용', 
    `u_id`       VARCHAR(50)      NOT NULL    COMMENT '이메일(계정아이디)', 
    `q_reply`    VARCHAR(4000)    NOT NULL    COMMENT '답변유무', 
    `q_date`     DATE                 DEFAULT now() NOT NULL COMMENT '질문날짜', 
    PRIMARY KEY (q_no)
);

ALTER TABLE tm_qna COMMENT '1:1질문';

CREATE INDEX tm_qna_pk ON tm_qna
(
    q_no
);

ALTER TABLE tm_qna ADD CONSTRAINT FK_tm_qna_u_id_tm_user_u_id FOREIGN KEY (u_id)
 REFERENCES tm_user (u_id)  ON DELETE RESTRICT ON UPDATE RESTRICT;


; 

